//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import FinanceRepository
import FinanceHome
import TransportHome
import TransportHomeImp
import Topup
import TopupImp
import UIKit
import AddPaymentMethod
import AddPaymentMethodImp
import NeedleFoundation

public final class AppRootBuilder: Component<AppRootDependency>, FinanceHomeDependency, TopupDependency, AddPaymentMethodDependency {
    public var superPayRepository: SuperPayRepositoryAvailable { SuperPayRepository() }
    public var cardOnFileRepository: CardOnFileRepositoryAvailable { CardOnFileRepository() }
    
    lazy public var transportHomeBuildable: TransportHomeBuildingLogic = {
       TransportHomeBuilder(parent: self)
    }()
    
    lazy public var topupBuildable: TopupBuildingLogic = {
       TopupBuilder(dependency: self)
    }()
    
    lazy public var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic = {
       AddPaymentMethodBuilder(dependency: self)
    }()
}
