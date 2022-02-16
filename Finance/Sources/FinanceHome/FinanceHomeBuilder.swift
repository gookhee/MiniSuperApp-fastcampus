import ModernRIBs
import FinanceRepository
import AddPaymentMethod
import FinanceRepository
import CombineUtil
import Topup

public protocol FinanceHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var topupBuildable: TopupBuildable { get }
}

/// 자식리블렛의 의존성을 여기서 충족시켜줘야함
final class FinanceHomeComponent: Component<FinanceHomeDependency>, SuperPayDashboardDependency, CardOnFileDashboardDependency, AddPaymentMethodDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    var topupBuildable: TopupBuildable { dependency.topupBuildable }

    /// 자식리블렛에서는 값을 읽기전용 타입을 넘김
    var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
}

// MARK: - Builder

public protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> ViewableRouting
}

public final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {

    public override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: FinanceHomeListener) -> ViewableRouting {
        let viewController = FinanceHomeViewController()
        let component = FinanceHomeComponent(dependency: dependency)
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener

        let superPayDashboardBuilder = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboardBuilder = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        return FinanceHomeRouter(
            interactor: interactor,
            viewController: viewController,
            superPayDashboardBuildable: superPayDashboardBuilder,
            cardOnFileDashboardBuildable: cardOnFileDashboardBuilder,
            addPaymentMethodBuildable: addPaymentMethodBuilder,
            topupBuildable: component.topupBuildable
        )
    }
}
