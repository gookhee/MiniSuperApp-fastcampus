//
//  AddPaymentMethodInterface.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import UIKit

import FinanceEntity
import SuperUI
import CleanSwiftUtil

// MARK: - AddPaymentMethodBuildingLogic definition

public protocol AddPaymentMethodBuildingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func build(listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> UIViewController
}

// MARK: - AddPaymentMethodListener

public protocol AddPaymentMethodListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToCloseButtonTappedFromAddPaymentMethod()
    func listenToPaymentMethodAdded(paymentMethod: PaymentMethod)
}
