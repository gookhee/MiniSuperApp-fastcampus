//
//  TransportHomeInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/28.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

import Combine
import CombineUtil
import FoundationExt
import TransportHome
import Topup

// MARK: - TransportHomeInteractor

final class TransportHomeInteractor {
    var presenter: TransportHomePresentationLogic?
    var router: TransportHomeRoutingLogic?
    private let worker: TransportHomeWorkingLogic
    private weak var listener: TransportHomeListener?
    private let dependency: TransportHomeInteractorDependency
    
    /// 강의 범위가 아니여서 하드코딩
    private let ridePrice: Double = 19000
    
    private var cancellables: Set<AnyCancellable>

    /// 자유롭게 매개변수 추가하기. worker, listener 등등  (Add parameters freely. worker, listener, etc)
    init(
        worker: TransportHomeWorkingLogic,
        dependency: TransportHomeInteractorDependency,
        listener: TransportHomeListener?
    ) {
        self.worker = worker
        self.dependency = dependency
        self.cancellables = .init()
        self.listener = listener
    }
}

// MARK: - TransportHomeRequestLogic

extension TransportHomeInteractor: TransportHomeRequestLogic {
    func process(_ request: TransportHome.Request.OnLoad) {
        presenter?.present(.ridePrice(ridePrice))
        dependency.superPayBalance
            .receive(on: DispatchQueue.main)
            .sink {[weak self] balance in
                self?.presenter?.present(.superPayBalance(balance))
            }
            .store(in: &cancellables)
    }
    
    func process(_ request: TransportHome.Request.OnViewDidDismiss) {
        router?.detachTopup()
    }
    
    func process(_ request: TransportHome.Request.OnGoBack) {
        listener?.transportHomeDidTapClose()
    }
    
    func process(_ request: TransportHome.Request.OnRideConfirmButton) {
        if dependency.superPayBalance.value < ridePrice {
            router?.attachTopup(listener: self)
        } else {
            /// 강의 범위 X
            print("success")
        }
    }
}

// MARK: - TopupListener

extension TransportHomeInteractor: TopupListener {
    func listenToTopupClosed() {
        router?.detachTopup()
    }
    
    func listenToTopupFinished() {
        router?.detachTopup()
    }
}

// MARK: - TransportHomeRequestLogic definition

protocol TransportHomeRequestLogic {
    /// 외부매개변수는 제외하기
    func process(_ request: TransportHome.Request.OnLoad)
    func process(_ request: TransportHome.Request.OnViewDidDismiss)
    func process(_ request: TransportHome.Request.OnGoBack)
    func process(_ request: TransportHome.Request.OnRideConfirmButton)
}

// MARK: - TransportHomeWorkingLogic definition

protocol TransportHomeWorkingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func doSomeWork()
}

// MARK: - TransportHomePresentationLogic definition

protocol TransportHomePresentationLogic {
    /// 외부매개변수는 제외하기
    func present(_ response: TransportHome.Response)
}

// MARK: - TransportHomeRoutingLogic definition

protocol TransportHomeRoutingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func attachTopup(listener: TopupListener)
    func detachTopup()
}

// MARK: - TransportHomeInteractorDependency

protocol TransportHomeInteractorDependency {
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { get }
}
