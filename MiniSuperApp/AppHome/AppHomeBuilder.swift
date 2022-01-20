import ModernRIBs

protocol AppHomeDependency: Dependency {
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
}

// MARK: - Builder

protocol AppHomeBuildable: Buildable {
    func build(withListener listener: AppHomeListener) -> ViewableRouting
}

final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {

    override init(dependency: AppHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppHomeListener) -> ViewableRouting {
        let component = AppHomeComponent(dependency: dependency)
        let viewController = AppHomeViewController()
        let interactor = AppHomeInteractor(presenter: viewController)
        interactor.listener = listener

        let transportHomeBuilder = TransportHomeBuilder(dependency: component)

        return AppHomeRouter(
            interactor: interactor,
            viewController: viewController,
            transportHomeBuildable: transportHomeBuilder
        )
    }
}
