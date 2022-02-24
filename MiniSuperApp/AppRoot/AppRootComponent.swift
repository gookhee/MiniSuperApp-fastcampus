//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/02/24.
//

import Foundation
import ModernRIBs
import FinanceRepository
import FinanceHome
import AppHome
import ProfileHome
import TransportHome
import TransportHomeImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency  {
    let superPayRepository: SuperPayRepositoryAvailable
    let cardOnFileRepository: CardOnFileRepositoryAvailable
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        TransportHomeBuilder(dependency: self)
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
}
