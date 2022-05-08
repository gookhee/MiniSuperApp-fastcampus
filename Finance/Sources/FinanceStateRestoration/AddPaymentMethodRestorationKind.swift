//
//  File.swift
//  
//
//  Created by 정국희 on 2022/04/27.
//

import Foundation
import FinanceEntity

public enum AddPaymentMethodRestorationKind {
    case unknown
    case financeHome(input: AddPaymentMethodInfo)
    
    init(data: [String: [String: Any]]?) {
        guard let data = data else {
            self = .unknown
            return
        }
        
        if let value = data["financeHome"] {
            let input = AddPaymentMethodInfo(
                number: value["number"] as? String ?? "",
                cvc: value["cvc"] as? String ?? "",
                expiration: value["expiration"] as? String ?? ""
            )
            self = .financeHome(input: input)
        } else {
            self = .unknown
        }
    }
    
    var data: [String: [String: Any]] {
        switch self {
        case let .financeHome(input):
            return [
                "financeHome": [
                    "number": input.number,
                    "cvc": input.cvc,
                    "expiration": input.expiration
                ]
            ]
        default:
            return ["unknown": [:]]
        }
    }
}
