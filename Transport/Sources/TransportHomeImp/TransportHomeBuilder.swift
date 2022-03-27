import ModernRIBs
import CombineUtil
import FinanceRepository
import Topup
import TransportHome

public protocol TransportHomeDependency: Dependency {
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var topupBuildable: TopupBuildingLogic { get }
}

final class TransportHomeComponent: Component<TransportHomeDependency>, TransportHomeInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { dependency.superPayRepository.balance }
    var topupBuildable: TopupBuildingLogic { dependency.topupBuildable }
}

// MARK: - Builder

public final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {
    
    public override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: TransportHomeListener) -> ViewableRouting {
        let viewController = TransportHomeViewController()
        let component = TransportHomeComponent(dependency: dependency)
        let interactor = TransportHomeInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        return TransportHomeRouter(
            interactor: interactor,
            viewController: viewController,
            topupBuildable: component.topupBuildable
        )
    }
}
