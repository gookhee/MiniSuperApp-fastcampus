//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import Foundation

/// 서버 응답
struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String /// hex
    let isPrimary: Bool
}
