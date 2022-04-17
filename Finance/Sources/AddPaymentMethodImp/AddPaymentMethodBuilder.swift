//
//  AddPaymentMethodBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/02/20.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

import FinanceRepository
import SuperUI
import AddPaymentMethod
import CleanSwiftUtil

// MARK: - AddPaymentMethodBuilder

public final class AddPaymentMethodBuilder: Builder<AddPaymentMethodDependency>, AddPaymentMethodBuildingLogic {
    public func build(listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> UIViewController {
        let viewController = AddPaymentMethodViewController(closeButtonType: closeButtonType)
        let worker = AddPaymentMethodWorker()
        let component = AddPaymentMethodComponent(dependency: dependency)
        let interactor = AddPaymentMethodInteractor(
            worker: worker,
            listener: listener,
            dependency: component
        )
        interactor.router = AddPaymentMethodRouter(viewController: viewController)
        viewController.interactor = interactor

        return viewController
    }
}

// MARK: - AddPaymentMethodDependency

public protocol AddPaymentMethodDependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
}

// MARK: - AddPaymentMethodComponent

final class AddPaymentMethodComponent:Component<AddPaymentMethodDependency>, AddPaymentMethodInteractorDependency {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
}

