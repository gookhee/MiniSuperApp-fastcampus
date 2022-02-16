import ModernRIBs
import FinanceEntity

protocol FinanceHomeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachSuperPayDashboard()
    func attachCardOnFileDashboard()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
    func attachTopup()
    func detachTopup()
}

protocol FinanceHomePresentable: Presentable {
    var listener: FinanceHomePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol FinanceHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable {
    
    weak var router: FinanceHomeRouting?
    weak var listener: FinanceHomeListener?
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FinanceHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        router?.attachSuperPayDashboard()
        router?.attachCardOnFileDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - CardOnFileDashboardListener
    
    func listenToAddPaymentMethodButtonPressed() {
        router?.attachAddPaymentMethod()
    }
    
    // MARK: - AddPaymentMethodListener
    
    func listenToCloseButtonTappedFromAddPaymentMethod() {
        router?.detachAddPaymentMethod()
    }
    
    func listenToPaymentMethodAdded(paymentMethod: PaymentMethod) {
        router?.detachAddPaymentMethod()
    }
    
    // MARK: - SuperPayDashboardListener
    
    func listenToTopupButtonTapped() {
        router?.attachTopup()
    }
    
    // MARK: - TopupListener
    
    func listenToTopupClosed() {
        router?.detachTopup()
    }
    
    func listenToTopupFinished() {
        router?.detachTopup()
    }
}

extension FinanceHomeInteractor: FinanceHomePresentableListener {
    func listenToScreenDismissed() {
        /// 여기서 다 호출해줘야함
        router?.detachAddPaymentMethod()
        router?.detachTopup()
    }
}
