//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/14.
//

import ModernRIBs
import Foundation

/// 잔고(balance publisher)는 빌더에서 빌드할때 받을 수 도 있고, 부모로부터 받을 수 도 있다.
/// 이 리블렛을 화면의 일부의 뷰를 담당하고,  거의 뷰를 그리는 역할을 하는 작은 부모한테 받는 것이 적합
/// 부모로 부터 받는 의존성은 SuperPayDashboardDependency에 정의해주면 됨
protocol SuperPayDashboardDependency: Dependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class SuperPayDashboardComponent: Component<SuperPayDashboardDependency>, SuperPayDashboardInteractorDependency{
    var balanceFormatter: NumberFormatter { Formatter.balanceFormatter }
    var balance: ReadOnlyCurrentValuePublisher<Double> {
        dependency.balance
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SuperPayDashboardBuildable: Buildable {
    func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting
}

final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency>, SuperPayDashboardBuildable {

    /// 상위 리블렛으로 부터 받는 의존성
    override init(dependency: SuperPayDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SuperPayDashboardListener) -> SuperPayDashboardRouting {
        let component = SuperPayDashboardComponent(dependency: dependency)
        let viewController = SuperPayDashboardViewController()
        let interactor = SuperPayDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return SuperPayDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
