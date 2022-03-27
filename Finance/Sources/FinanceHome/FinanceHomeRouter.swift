import ModernRIBs
import UIKit
import AddPaymentMethod
import Topup
import RIBsUtil
import CleanSwiftUtil

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener, AddPaymentMethodListener, TopupListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable, TopupBaseViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func addDashboard(_ view: UIViewController)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    private let superPayDashboardBuildable: SuperPayDashboardBuildingLogic
    private var superPayRouting: UIViewController?
    
    private let cardOnFileDashboardBuildable: CardOnFileDashboardBuildingLogic
    private var cardOnFileRouting: UIViewController?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildingLogic
    private var addPaymentMethodRouting: UIViewController?
    
    private let topupBuildable: TopupBuildingLogic
    private var topupRouting: ViewlessInteracting?
    
    /// !!! router가 interacter를 주입받는다.
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: FinanceHomeInteractable,
        viewController: FinanceHomeViewControllable,
        superPayDashboardBuildable: SuperPayDashboardBuildingLogic,
        cardOnFileDashboardBuildable: CardOnFileDashboardBuildingLogic,
        addPaymentMethodBuildable: AddPaymentMethodBuildingLogic,
        topupBuildable: TopupBuildingLogic
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
        let destination = superPayDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(destination)
        
        self.superPayRouting = destination
    }
    
    func attachCardOnFileDashboard() {
        if cardOnFileRouting != nil {
            return
        }
        let destination = cardOnFileDashboardBuildable.build(withListener: interactor)
        
        viewController.addDashboard(destination)
        
        self.cardOnFileRouting = destination
    }
    
    func attachAddPaymentMethod() {
        guard nil == addPaymentMethodRouting else { return }
        
        let destination = addPaymentMethodBuildable.build(listener: interactor, closeButtonType: .close)
        
        let navigationController = UINavigationController(rootViewController: destination)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
 
        navigationController.presentationController?.delegate = viewController.presentationDelegate
        viewController.present(navigationController, animated: true, completion: nil)
        
        addPaymentMethodRouting = destination
    }
    
    func detachAddPaymentMethod() {
        guard nil != addPaymentMethodRouting else { return }
        
        viewController.dismiss(animated: true, completion: nil)
        
        addPaymentMethodRouting = nil
    }
    
    func attachTopup() {
        guard nil == topupRouting else { return }
        
        let destination = topupBuildable.build(
            withListener: interactor,
            topupBaseViewController: viewController
        )
        
        destination.activate()
        
        topupRouting = destination
    }
    
    func detachTopup() {
        guard nil != topupRouting else { return }
        
        topupRouting?.deactivate()
        topupRouting = nil
    }
}
