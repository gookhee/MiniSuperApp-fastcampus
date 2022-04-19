//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import FinanceRepository
import FinanceHome
import AppHome
import ProfileHome
import TransportHome
import TransportHomeImp
import Topup
import TopupImp
import UIKit
import AddPaymentMethod
import AddPaymentMethodImp
import NeedleFoundation

final class AppRootModuleComponent: Component<AppRootModuleDependency>, AppRootModuleBuildable, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
    let superPayRepository: SuperPayRepositoryAvailable
    let cardOnFileRepository: CardOnFileRepositoryAvailable
    
    lazy var transportHomeBuildable: TransportHomeBuildingLogic = {
       TransportHomeBuilder(dependency: self)
    }()
    
    lazy var topupBuildable: TopupBuildingLogic = {
       TopupBuilder(dependency: self)
    }()
    
    lazy var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic = {
       AddPaymentMethodBuilder(dependency: self)
    }()
    
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
    
    var appRootBuilder: AppRootBuildingLogic {
        
    }
}

// MARK: - AppRootModuleBuildable

protocol AppRootModuleBuildable {
    var appRootBuilder: AppRootBuildingLogic { get }
}

// MARK: - AppRootModuleDependency

protocol AppRootModuleDependency {
     
}
