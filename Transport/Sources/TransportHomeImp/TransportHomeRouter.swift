import UIKit

import ModernRIBs
import Topup
import TransportHome
import CleanSwiftUtil

protocol TransportHomeInteractable: Interactable, TopupListener {
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable, TopupBaseViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
    
    private let topupBuildable: TopupBuildingLogic
    private var topupRouting: ViewlessInteracting?
    
    init(
        interactor: TransportHomeInteractable,
        viewController: TransportHomeViewControllable,
        topupBuildable: TopupBuildingLogic
    ) {
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopup() {
        guard nil == topupRouting else { return }
        
        let destination = topupBuildable.build(
            withListener: interactor,
            topupBaseViewController: viewController
        )
        
        topupRouting = destination
        
        destination.activate()
    }
    
    func detachTopup() {
        guard nil != topupRouting else { return }
        
        topupRouting?.deactivate()
        topupRouting = nil
    }
    
}
