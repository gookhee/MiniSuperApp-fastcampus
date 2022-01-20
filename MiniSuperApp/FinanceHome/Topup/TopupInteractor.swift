//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
    func popToRoot()
}

protocol TopupListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToTopupClosed()
    func listenToTopupFinished()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable {
    weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    private let dependency: TopupInteractorDependency
    
    private var paymentMethods: [PaymentMethod] {
        dependency.cardOnFileRepository.cardOnFile.value
    }
    
    private var isEnterAmountRoot = false
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(dependency: TopupInteractorDependency) {
        self.dependency = dependency
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        if let firstCard = dependency.cardOnFileRepository.cardOnFile.value.first {
            /// 충전 화면
            isEnterAmountRoot = true
            dependency.paymentMethodStream.send(firstCard)
            router?.attachEnterAmount()
        } else {
            /// 카드 추가 화면
            isEnterAmountRoot = false
            router?.attachAddPaymentMethod(closeButtonType: .close)
        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    // MARK: - AddPaymentMethodListener
    
    func listenToCloseButtonTappedFromAddPaymentMethod() {
        router?.detachAddPaymentMethod()
        if false == isEnterAmountRoot {
            listener?.listenToTopupClosed()
        }
    }
    
    func listenToPaymentMethodAdded(paymentMethod: PaymentMethod) {
        dependency.paymentMethodStream.send(paymentMethod)
        if isEnterAmountRoot {
            //router?.popToRoot()
            router?.detachEnterAmount()
            router?.attachEnterAmount()
        } else {
            isEnterAmountRoot = true
            router?.attachEnterAmount()
        }
    }
    
    // MARK: - EnterAmountListener
    
    func listenToCloseButtonTappedFromEnterAmount() {
        router?.detachEnterAmount()
        listener?.listenToTopupClosed()
    }
    
    func listenToPaymentMethodButtonTapped() {
        router?.attachCardOnFile(paymentMethods: paymentMethods)
    }
    
    func listenToTopupFinishedFromEnterAmount() {
        listener?.listenToTopupFinished()
    }
    
    // MARK: - CardOnFileListener
    
    func listenToCloseButtonTappedFromCardOnFile() {
        router?.detachCardOnFile()
    }
    
    func listenToItemSelectedFromCardOnFile(at index: Int) {
        if let paymentMethod = paymentMethods[safe: index] {
            dependency.paymentMethodStream.send(paymentMethod)
            router?.detachCardOnFile()
        }
    }
    
    func listenToAddPaymentMethodButtonTappedFromCardOnFile() {
        router?.attachAddPaymentMethod(closeButtonType: .back)
    }
}
