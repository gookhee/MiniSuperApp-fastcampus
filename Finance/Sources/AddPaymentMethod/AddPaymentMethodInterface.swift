//
//  AddPaymentMethodInterface.swift
//  
//
//  Created by GOOK HEE JUNG on 2022/03/03.
//

import Foundation
import ModernRIBs
import RIBsExt
import FinanceEntity

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
