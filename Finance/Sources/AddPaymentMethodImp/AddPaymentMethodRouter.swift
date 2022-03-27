//
//  AddPaymentMethodRouter.swift
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

// MARK: - AddPaymentMethodRouter

final class AddPaymentMethodRouter: NSObject {
    weak var viewController: UIViewController?
    
    /// 자유롭게 다른 scene builder 추가하기 (Freely add builders of different scenes)
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

// MARK: - AddPaymentMethodRoutingLogic

extension AddPaymentMethodRouter: AddPaymentMethodRoutingLogic {
    
    func routeToSomewhere() {
        
    }
}
