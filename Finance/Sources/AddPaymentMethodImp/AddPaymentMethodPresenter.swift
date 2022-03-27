//
//  AddPaymentMethodPresenter.swift
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

// MARK: - AddPaymentMethodPresenter

final class AddPaymentMethodPresenter {
    weak var viewController: AddPaymentMethodDisplayLogic?
}

// MARK: - AddPaymentMethodPresentationLogic

extension AddPaymentMethodPresenter: AddPaymentMethodPresentationLogic {
    
    func present(_ response: AddPaymentMethod.Response) {
        
    }
}

// MARK: - AddPaymentMethodDisplayLogic definition

protocol AddPaymentMethodDisplayLogic: AnyObject {
    /// 외부매개변수는 제외하기
}
