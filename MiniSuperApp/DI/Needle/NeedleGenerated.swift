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
import FinanceHome
import FinanceRepository
import Foundation
import NeedleFoundation
import ProfileHome
import Topup
import TopupImp
import TransportHome
import TransportHomeImp
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootBuilder") { component in
        return AppRootDependencye8b8e4c3df015f34c868Provider(component: component)
    }
    
}

// MARK: - Providers

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
