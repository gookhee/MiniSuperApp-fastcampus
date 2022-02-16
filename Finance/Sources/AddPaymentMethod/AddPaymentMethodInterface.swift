//
//  AddPaymentMethodInterface.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import ModernRIBs
import FinanceEntity
import RIBsUtil

public protocol AddPaymentMethodBuildable: Buildable {
    func build(
        withListener listener: AddPaymentMethodListener,
        closeButtonType: DismissButtonType
    ) -> ViewableRouting
}

public protocol AddPaymentMethodListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToCloseButtonTappedFromAddPaymentMethod()
    func listenToPaymentMethodAdded(paymentMethod: PaymentMethod)
}
