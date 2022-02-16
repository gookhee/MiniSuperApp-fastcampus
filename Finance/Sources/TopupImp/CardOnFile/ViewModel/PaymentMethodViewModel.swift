//
//  PaymentMethodViewModel.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import UIKit
import FinanceEntity
import SuperUI

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor

    init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = UIColor(hex: paymentMethod.color) ?? .systemGray2
    }
}
