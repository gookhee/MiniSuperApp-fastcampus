//
//  CardOnFileInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/19.
//

import ModernRIBs

protocol CardOnFileRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFilePresentable: Presentable {
    var listener: CardOnFilePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func update(with viewModel: [PaymentMethodViewModel])
}

protocol CardOnFileListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToCloseButtonTappedFromCardOnFile()
    func listenToItemSelectedFromCardOnFile(at index: Int)
    func listenToAddPaymentMethodButtonTappedFromCardOnFile()
}

final class CardOnFileInteractor: PresentableInteractor<CardOnFilePresentable>, CardOnFileInteractable, CardOnFilePresentableListener {
    weak var router: CardOnFileRouting?
    weak var listener: CardOnFileListener?
    private let paymentMethods: [PaymentMethod]

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: CardOnFilePresentable, paymentMethods: [PaymentMethod]) {
        self.paymentMethods = paymentMethods
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        let viewModel = paymentMethods.map(PaymentMethodViewModel.init)
        presenter.update(with: viewModel)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    func didTapClose() {
        listener?.listenToCloseButtonTappedFromCardOnFile()
    }

    func didSelectItem(at index: Int) {
        if index < paymentMethods.count {
            listener?.listenToItemSelectedFromCardOnFile(at: index)
        } else {
            listener?.listenToAddPaymentMethodButtonTappedFromCardOnFile()
        }
    }
}
