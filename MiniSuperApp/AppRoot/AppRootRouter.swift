import UIKit

import ModernRIBs
import RIBsUtil
import FinanceHome
import AppHome
import ProfileHome

protocol AppRootInteractable: Interactable,
    AppHomeListener,
    FinanceHomeListener,
    ProfileHomeListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [UIViewController])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let appHome: AppHomeBuildable
    private let financeHome: FinanceHomeBuildingLogic
    private let profileHome: ProfileHomeBuildingLogic
    
    private var appHomeRouting: UIViewController?
    private var financeHomeRouting: UIViewController?
    private var profileHomeRouting: UIViewController?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        appHome: AppHomeBuildable,
        financeHome: FinanceHomeBuildingLogic,
        profileHome: ProfileHomeBuildingLogic
    ) {
        self.appHome = appHome
        self.financeHome = financeHome
        self.profileHome = profileHome
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        let appHomeRouting = appHome.build(withListener: interactor)
        let financeHomeRouting = financeHome.build(withListener: interactor)
        let profileHomeRouting = profileHome.build(withListener: interactor)
        
        attachChild(appHomeRouting)
        
        let viewControllers = [
            navigationController(rootViewController: appHomeRouting.viewControllable.uiviewController),
            navigationController(rootViewController: financeHomeRouting),
            profileHomeRouting
        ]
        
        viewController.setViewControllers(viewControllers)
    }
    
    func navigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
        return navigation
    }
}
