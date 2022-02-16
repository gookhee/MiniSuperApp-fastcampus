import ModernRIBs
import CombineUtil
import FinanceRepository
import Topup

protocol TransportHomeDependency: Dependency {
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency, TopupDependency {
    var topupBaseViewController: TopupBaseViewControllable
    
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { dependency.superPayRepository.balance }
    
    init(
        dependency: TransportHomeDependency,
        topupBaseViewController: TopupBaseViewControllable
    ) {
        self.topupBaseViewController = topupBaseViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol TransportHomeBuildable: Buildable {
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting
}

final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting {
        let viewController = TransportHomeViewController()
        let component = TransportHomeComponent(
            dependency: dependency,
            topupBaseViewController: viewController
        )
        
        let topupBuilder = TopupBuilder(dependency: component)
        
        let interactor = TransportHomeInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        return TransportHomeRouter(
            interactor: interactor,
            viewController: viewController,
            topupBuildable: topupBuilder
        )
    }
}
