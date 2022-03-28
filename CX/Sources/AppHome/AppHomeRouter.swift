import ModernRIBs
import SuperUI
import TransportHome
import UIKit

protocol AppHomeInteractable: Interactable, TransportHomeListener {
    var router: AppHomeRouting? { get set }
    var listener: AppHomeListener? { get set }
}

protocol AppHomeViewControllable: ViewControllable {
    
}

final class AppHomeRouter: ViewableRouter<AppHomeInteractable, AppHomeViewControllable>, AppHomeRouting {
    private let transportHomeBuildable: TransportHomeBuildingLogic
    private var transportHomeRouting: UIViewController?
    private let transitioningDelegate: PushModalPresentationController
    
    init(
        interactor: AppHomeInteractable,
        viewController: AppHomeViewControllable,
        transportHomeBuildable: TransportHomeBuildingLogic
    ) {
        self.transitioningDelegate = PushModalPresentationController()
        self.transportHomeBuildable = transportHomeBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTransportHome() {
        if transportHomeRouting != nil {
            return
        }
        
        let destination = transportHomeBuildable.build(withListener: interactor)
        presentWithPushTransition(destination, animated: true)
        self.transportHomeRouting = destination
    }
    
    func detachTransportHome() {
        guard nil != transportHomeRouting else {
            return
        }
        
        viewController.dismiss(completion: nil)
        self.transportHomeRouting = nil
    }
    
    private func presentWithPushTransition(_ viewControllable: UIViewController, animated: Bool) {
        viewControllable.modalPresentationStyle = .custom
        viewControllable.transitioningDelegate = transitioningDelegate
        viewController.uiviewController.present(viewControllable, animated: true, completion: nil)
    }
    
}
