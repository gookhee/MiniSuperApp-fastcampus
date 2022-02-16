import ModernRIBs
import UIKit
import FinanceRepository
import FinanceHome
import AppHome
import ProfileHome

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency  {
    let superPayRepository: SuperPayRepositoryAvailable
    let cardOnFileRepository: CardOnFileRepositoryAvailable
    
    init(
        dependency: AppRootDependency,
        superPayRepository: SuperPayRepositoryAvailable,
        cardOnFileRepository: CardOnFileRepositoryAvailable
    ) {
        self.superPayRepository = superPayRepository
        self.cardOnFileRepository = cardOnFileRepository
        super.init(dependency: dependency)
    }
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler)
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {
    
    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> (launchRouter: LaunchRouting, urlHandler: URLHandler) {
        let component = AppRootComponent(
            dependency: dependency,
            superPayRepository: SuperPayRepository(),
            cardOnFileRepository: CardOnFileRepository()
        )
        
        let tabBar = RootTabBarController()
        
        let interactor = AppRootInteractor(presenter: tabBar)
        
        let appHome = AppHomeBuilder(dependency: component)
        let financeHome = FinanceHomeBuilder(dependency: component)
        let profileHome = ProfileHomeBuilder(dependency: component)
        let router = AppRootRouter(
            interactor: interactor,
            viewController: tabBar,
            appHome: appHome,
            financeHome: financeHome,
            profileHome: profileHome
        )
        
        return (router, interactor)
    }
}
