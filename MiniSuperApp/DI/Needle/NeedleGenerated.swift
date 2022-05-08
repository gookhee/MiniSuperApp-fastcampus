//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import AddPaymentMethod
import AddPaymentMethodImp
import AppHome
import CleanSwiftUtil
import CombineUtil
import FinanceEntity
import FinanceHome
import FinanceRepository
import Foundation
import NeedleFoundation
import ProfileHome
import SuperUI
import Topup
import TopupImp
import TransportHome
import TransportHomeImp
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder->TransportHomeBuilder") { component in
        return TransportHomeDependency66d6c53f06d8c3d01feeProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder") { component in
        return AppRootDependencye8b8e4c3df015f34c868Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder->ProfileHomeBuilder") { component in
        return ProfileHomeDependency61241a7b21e0a17364f8Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder->AddPaymentMethodBuilder") { component in
        return AddPaymentMethodDependency4a47be77669ea982f0cdProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder->TopupBuilder") { component in
        return TopupDependency53480cc7ff6d4b968404Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder->AppHomeBuilder") { component in
        return AppHomeDependencyd7aa6a600f725039513eProvider(component: component)
    }
    
}

// MARK: - Providers

private class TransportHomeDependency66d6c53f06d8c3d01feeBaseProvider: TransportHomeDependency {
    var superPayRepository: SuperPayRepositoryAvailable {
        return appRootBuilder.superPayRepository
    }
    var cardOnFileRepository: CardOnFileRepositoryAvailable {
        return appRootBuilder.cardOnFileRepository
    }
    var topupBuildable: TopupBuildingLogic {
        return appRootBuilder.topupBuildable
    }
    private let appRootBuilder: AppRootBuilder
    init(appRootBuilder: AppRootBuilder) {
        self.appRootBuilder = appRootBuilder
    }
}
/// ^->AppComponent->AppRootBuilder->TransportHomeBuilder
private class TransportHomeDependency66d6c53f06d8c3d01feeProvider: TransportHomeDependency66d6c53f06d8c3d01feeBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(appRootBuilder: component.parent as! AppRootBuilder)
    }
}
private class AppRootDependencye8b8e4c3df015f34c868BaseProvider: AppRootDependency {


    init() {

    }
}
/// ^->AppComponent->AppRootBuilder
private class AppRootDependencye8b8e4c3df015f34c868Provider: AppRootDependencye8b8e4c3df015f34c868BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
    }
}
private class ProfileHomeDependency61241a7b21e0a17364f8BaseProvider: ProfileHomeDependency {


    init() {

    }
}
/// ^->AppComponent->AppRootBuilder->ProfileHomeBuilder
private class ProfileHomeDependency61241a7b21e0a17364f8Provider: ProfileHomeDependency61241a7b21e0a17364f8BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
    }
}
private class AddPaymentMethodDependency4a47be77669ea982f0cdBaseProvider: AddPaymentMethodDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable {
        return appRootBuilder.cardOnFileRepository
    }
    private let appRootBuilder: AppRootBuilder
    init(appRootBuilder: AppRootBuilder) {
        self.appRootBuilder = appRootBuilder
    }
}
/// ^->AppComponent->AppRootBuilder->AddPaymentMethodBuilder
private class AddPaymentMethodDependency4a47be77669ea982f0cdProvider: AddPaymentMethodDependency4a47be77669ea982f0cdBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(appRootBuilder: component.parent as! AppRootBuilder)
    }
}
private class TopupDependency53480cc7ff6d4b968404BaseProvider: TopupDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable {
        return appRootBuilder.cardOnFileRepository
    }
    var superPayRepository: SuperPayRepositoryAvailable {
        return appRootBuilder.superPayRepository
    }
    var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic {
        return appRootBuilder.addPaymentMethodBuildable
    }
    private let appRootBuilder: AppRootBuilder
    init(appRootBuilder: AppRootBuilder) {
        self.appRootBuilder = appRootBuilder
    }
}
/// ^->AppComponent->AppRootBuilder->TopupBuilder
private class TopupDependency53480cc7ff6d4b968404Provider: TopupDependency53480cc7ff6d4b968404BaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(appRootBuilder: component.parent as! AppRootBuilder)
    }
}
private class AppHomeDependencyd7aa6a600f725039513eBaseProvider: AppHomeDependency {
    var superPayRepository: SuperPayRepositoryAvailable {
        return appRootBuilder.superPayRepository
    }
    var cardOnFileRepository: CardOnFileRepositoryAvailable {
        return appRootBuilder.cardOnFileRepository
    }
    var transportHomeBuildable: TransportHomeBuildingLogic {
        return appRootBuilder.transportHomeBuildable
    }
    private let appRootBuilder: AppRootBuilder
    init(appRootBuilder: AppRootBuilder) {
        self.appRootBuilder = appRootBuilder
    }
}
/// ^->AppComponent->AppRootBuilder->AppHomeBuilder
private class AppHomeDependencyd7aa6a600f725039513eProvider: AppHomeDependencyd7aa6a600f725039513eBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init(appRootBuilder: component.parent as! AppRootBuilder)
    }
}
