//
//  AppRootBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/28.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

import FinanceRepository
import FinanceHome
import AppHome
import ProfileHome
import CleanSwiftUtil

// MARK: - AppRootBuilder

public final class AppRootBuilder: Builder<AppRootDependency> {

}

// MARK: - AppRootBuildingLogic

extension AppRootBuilder: AppRootBuildingLogic {
    public func build(listener: AppRootListener?) -> Destination {
        let component = AppRootComponent(
            dependency: dependency
        )
        let interactor = AppRootInteractor(
            worker: AppRootWorker(),
            listener: listener
        )
        let appHome = AppHomeBuilder(dependency: component)
        let financeHome = FinanceHomeBuilder(dependency: component)
        let profileHome = ProfileHomeBuilder(dependency: component)

        let viewController = AppRootViewController(
            appHomeViewController:
                appHome.build(withListener: interactor),
            financeHomeViewConroller: financeHome.build(withListener: interactor),
            profileHomeViewConroller: profileHome.build(withListener: interactor)
        )

        let presenter = AppRootPresenter()

        let router = AppRootRouter(viewController: viewController)
        viewController.interactor = interactor
        interactor.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController

        return viewController
    }
}

// MARK: - AppRootBuildingLogic definition

public protocol AppRootBuildingLogic {
    typealias Destination = UIViewController
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func build(listener: AppRootListener?) -> Destination
}

// MARK: - AppRootDependency

public protocol AppRootDependency: CleanSwiftDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}
