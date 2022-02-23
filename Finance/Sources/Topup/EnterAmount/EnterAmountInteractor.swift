//
//  EnterAmountInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/18.
//

import ModernRIBs
import Foundation
import Combine
import CombineUtil
import FinanceEntity
import FinanceRepository

protocol EnterAmountRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EnterAmountPresentable: Presentable {
    var listener: EnterAmountPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func updateSelectedPaymentMethod(with viewModel: SelectedPaymentMethodViewModel)
    func startLoading()
    func stopLoading()
}

protocol EnterAmountListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToCloseButtonTappedFromEnterAmount()
    func listenToPaymentMethodButtonTapped()
    func listenToTopupFinishedFromEnterAmount()
}

protocol EnterAmountInteractorDependency {
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { get }
    var superPayRepository: SuperPayRepositoryAvailable { get }
}

final class EnterAmountInteractor: PresentableInteractor<EnterAmountPresentable>, EnterAmountInteractable, EnterAmountPresentableListener {
    weak var router: EnterAmountRouting?
    weak var listener: EnterAmountListener?
    private var cancellables: Set<AnyCancellable>

    private let dependency: EnterAmountInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: EnterAmountPresentable, dependency: EnterAmountInteractorDependency) {
        self.cancellables = .init()
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.

        dependency.selectedPaymentMethod.sink {[weak self] paymentMethod in
            self?.presenter.updateSelectedPaymentMethod(with: SelectedPaymentMethodViewModel(paymentMethod))
        }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func didTapClose() {
        listener?.listenToCloseButtonTappedFromEnterAmount()
    }

    func didTapPaymentMethod() {
        listener?.listenToPaymentMethodButtonTapped()
    }

    func didTapTopup(with amount: Double) {
        presenter.startLoading()

        dependency.superPayRepository.topup(
            amount: amount,
            paymentMethodID: dependency.selectedPaymentMethod.value.id
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: {[weak self] _ in
                self?.presenter.stopLoading()
            },
            receiveValue: {[weak self] in
                self?.listener?.listenToTopupFinishedFromEnterAmount()
            }
        )
        .store(in: &cancellables)
    }
}
