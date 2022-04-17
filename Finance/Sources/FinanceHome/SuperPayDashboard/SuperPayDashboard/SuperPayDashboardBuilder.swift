//
//  SuperPayDashboardBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/27.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

import CleanSwiftUtil
import FinanceRepository
import AddPaymentMethod
import FinanceRepository
import CombineUtil
import Topup

// MARK: - SuperPayDashboardBuilder

final class SuperPayDashboardBuilder: Builder<SuperPayDashboardDependency> {

}

// MARK: - SuperPayDashboardBuildingLogic

extension SuperPayDashboardBuilder: SuperPayDashboardBuildingLogic {
    
    func build(withListener listener: SuperPayDashboardListener) -> Destination {
        let component = SuperPayDashboardComponent(dependency: dependency)
        
        let viewController = SuperPayDashboardViewController()
        let interactor = SuperPayDashboardInteractor(
            worker: SuperPayDashboardWorker(),
            listener: listener,
            dependency: component
        )
        let presenter = SuperPayDashboardPresenter()
        let router = SuperPayDashboardRouter(viewController: viewController)
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController

        return viewController
    }

}

// MARK: - SuperPayDashboardBuildingLogic definition

protocol SuperPayDashboardBuildingLogic {
    typealias Destination = SuperPayDashboardViewController
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func build(withListener listener: SuperPayDashboardListener) -> Destination
}

// MARK: - SuperPayDashboardDependency

/// 잔고(balance publisher)는 빌더에서 빌드할때 받을 수 도 있고, 부모로부터 받을 수 도 있다.
/// 이 리블렛을 화면의 일부의 뷰를 담당하고,  거의 뷰를 그리는 역할을 하는 작은 부모한테 받는 것이 적합
/// 부모로 부터 받는 의존성은 SuperPayDashboardDependency에 정의해주면 됨
protocol SuperPayDashboardDependency: CleanSwiftDependency {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
}

// MARK: - SuperPayDashboardComponent

final class SuperPayDashboardComponent: CleanSwiftComponent<SuperPayDashboardDependency>, SuperPayDashboardInteractorDependency{
    var balance: ReadOnlyCurrentValuePublisher<Double> {
        dependency.balance
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}
