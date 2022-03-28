//
//  AppRootModels.swift
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

enum AppRoot {

    enum Request {
        struct OnLoad {}
    }
    
    enum Response: Equatable {
        case something(String)
    }
    
    enum ViewModel {
        struct Something {
            let data: String
        }
    }
}
