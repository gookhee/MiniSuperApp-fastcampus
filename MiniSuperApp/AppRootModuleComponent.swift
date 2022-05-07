//
//  AppRootModuleComponent.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/04/17.
//
import Foundation

import NeedleFoundation

// MARK: - AppRootModuleComponent

final class AppRootModuleComponent: Component<AppRootModuleDependency>, AppRootModuleBuildable, AppRootDependency {
    var appRootBuilder: AppRootBuildingLogic {
        AppRootBuilder(dependency: self)
    }
}

// MARK: - AppRootModuleBuildable

protocol AppRootModuleBuildable: ModuleBuildable {
    var appRootBuilder: AppRootBuildingLogic { get }
}

// MARK: - AppRootModuleDependency

protocol AppRootModuleDependency: Dependency {
}

