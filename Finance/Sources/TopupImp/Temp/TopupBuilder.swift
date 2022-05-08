//
//  TopupBuilder.swift
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
import CombineUtil
import AddPaymentMethod
import FinanceEntity
import Topup
import NeedleFoundation

// MARK: - TopupBuilder

public final class TopupBuilder: Component<TopupDependency>, TopupInteractorDependency, EnterAmountDependency, CardOnFileDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }

    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> {
        CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
    }
}


// MARK: - TopupBuildingLogic

extension TopupBuilder: TopupBuildingLogic {
    public func build(
        withListener listener: TopupListener,
        topupBaseViewController: TopupBaseViewControllable
    ) -> Destination {
        let interactor = TopupInteractor(worker: TopupWorker(), listener: listener, dependency: self)
        let enterAmountBuilder = EnterAmountBuilder(dependency: self)
        let cardOnFileBuilder = CardOnFileBuilder(dependency: self)
        let router = TopupRouter(
            viewController: topupBaseViewController,
            addPaymentMethodBuildable: dependency.addPaymentMethodBuildable,
            enterAmountBuildable: enterAmountBuilder,
            cardOnFileBuildable: cardOnFileBuilder
        )
        interactor.router = router
        
        return interactor
    }
}

// MARK: - TopupDependency

public protocol TopupDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic { get }
}
