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

import Foundation
import NeedleFoundation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->AppRootModuleComponent") { component in
        return AppRootModuleDependencya6454dbe926f425bc76aProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

private class AppRootModuleDependencya6454dbe926f425bc76aBaseProvider: AppRootModuleDependency {


    init() {

    }
}
/// ^->AppComponent->AppRootModuleComponent
private class AppRootModuleDependencya6454dbe926f425bc76aProvider: AppRootModuleDependencya6454dbe926f425bc76aBaseProvider {
    init(component: NeedleFoundation.Scope) {
        super.init()
    }
}
