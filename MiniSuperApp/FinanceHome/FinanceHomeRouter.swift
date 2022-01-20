import ModernRIBs
import UIKit

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener, AddPaymentMethodListener, TopupListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    var presentationDelegate: UIAdaptivePresentationControllerDelegate { get }
    
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashboardBuildable
    private var superPayRouting: Routing?
    
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    private var cardOnFileRouting: Routing?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    
    private let topupBuildable: TopupBuildable
    private var topupRouting: Routing?
    
    /// !!! router가 interacter를 주입받는다.
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashboardBuildable,
        cardOnFileDashboardBuildable: CardOnFileDashboardBuildable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable,
        topupBuildable: TopupBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboardBuildable
        self.cardOnFileDashboardBuildable = cardOnFileDashboardBuildable
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if superPayRouting != nil {
            return
        }
        let router = superPayDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        
        viewController.addDashboard(dashboard)
        
        self.superPayRouting = router
        attachChild(router)
        
    }
    
    func attachCardOnFileDashboard() {
        if cardOnFileRouting != nil {
            return
        }
        let router = cardOnFileDashboardBuildable.build(withListener: interactor)
        
        let dashboard = router.viewControllable
        
        viewController.addDashboard(dashboard)
        
        self.cardOnFileRouting = router
        attachChild(router)
        
    }
    
    func attachAddPaymentMethod() {
        guard nil == addPaymentMethodRouting else { return }
        
        let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: .close)
        let navigationController = NavigationControllerable(root: router.viewControllable)
        navigationController.navigationController.presentationController?.delegate = viewController.presentationDelegate
        viewController.present(navigationController, animated: true, completion: nil)
        
        addPaymentMethodRouting = router
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else { return }
        
        viewController.dismiss(completion: nil)
        
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    func attachTopup() {
        guard nil == topupRouting else { return }
        
        let router = topupBuildable.build(withListener: interactor)
        
        attachChild(router)
        topupRouting = router
    }
    
    func detachTopup() {
        guard let router = topupRouting else { return }
        detachChild(router)
        topupRouting = nil
    }
}
