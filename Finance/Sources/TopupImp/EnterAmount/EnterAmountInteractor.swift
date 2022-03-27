//
//  EnterAmountInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/27.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation
import Combine
import CombineUtil
import FinanceEntity
import FinanceRepository

// MARK: - EnterAmountInteractor

final class EnterAmountInteractor {
    var presenter: EnterAmountPresentationLogic?
    var router: EnterAmountRoutingLogic?
    weak var listener: EnterAmountListener?
    private let worker: EnterAmountWorkingLogic
    private var cancellables: Set<AnyCancellable>
    private let dependency: EnterAmountInteractorDependency

    /// 자유롭게 매개변수 추가하기. worker, listener 등등  (Add parameters freely. worker, listener, etc)
    init(worker: EnterAmountWorkingLogic, listener: EnterAmountListener?, dependency: EnterAmountInteractorDependency) {
        self.worker = worker
        self.listener = listener
        self.dependency = dependency
        self.cancellables = .init()
    }
}

// MARK: - EnterAmountRequestLogic

extension EnterAmountInteractor: EnterAmountRequestLogic {
    func process(_ request: EnterAmount.Request.OnLoad) {
        dependency.selectedPaymentMethod.sink {[weak self] paymentMethod in
            self?.presenter?.present(.selectedPaymentMethod(paymentMethod))
        }.store(in: &cancellables)
    }
    
    func process(_ request: EnterAmount.Request.OnClose) {
        listener?.listenToCloseButtonTappedFromEnterAmount()
    }
    
    func process(_ request: EnterAmount.Request.OnTopup) {
        presenter?.present(.loadingIndicator(show: true))

        dependency.superPayRepository.topup(
            amount: request.amount,
            paymentMethodID: dependency.selectedPaymentMethod.value.id
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: {[weak self] _ in
                self?.presenter?.present(.loadingIndicator(show: false))
            },
            receiveValue: {[weak self] in
                self?.listener?.listenToTopupFinishedFromEnterAmount()
            }
        )
        .store(in: &cancellables)
    }
    
    func process(_ request: EnterAmount.Request.OnAddPaymentMethod) {
        listener?.listenToPaymentMethodButtonTapped()
    }
}

// MARK: - EnterAmountRequestLogic definition

protocol EnterAmountRequestLogic {
    /// 외부매개변수는 제외하기
    func process(_ request: EnterAmount.Request.OnLoad)
    func process(_ request: EnterAmount.Request.OnClose)
    func process(_ request: EnterAmount.Request.OnTopup)
    func process(_ request: EnterAmount.Request.OnAddPaymentMethod)
}

// MARK: - EnterAmountWorkingLogic definition

protocol EnterAmountWorkingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func doSomeWork()
}

// MARK: - EnterAmountPresentationLogic definition

protocol EnterAmountPresentationLogic {
    /// 외부매개변수는 제외하기
    func present(_ response: EnterAmount.Response)
}

// MARK: - EnterAmountRoutingLogic definition

protocol EnterAmountRoutingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func routeToSomewhere()
}

// MARK: - EnterAmountInteractorDependency

protocol EnterAmountInteractorDependency {
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { get }
    var superPayRepository: SuperPayRepositoryAvailable { get }
}

// MARK: - EnterAmountListener

protocol EnterAmountListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToCloseButtonTappedFromEnterAmount()
    func listenToPaymentMethodButtonTapped()
    func listenToTopupFinishedFromEnterAmount()
}
