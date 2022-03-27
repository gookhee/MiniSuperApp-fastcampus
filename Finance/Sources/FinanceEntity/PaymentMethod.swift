//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import Foundation

/// 서버 응답
public struct PaymentMethod: Decodable, Equatable {
    public let id: String
    public let name: String
    public let digits: String
    public let color: String /// hex
    public let isPrimary: Bool
    
    public init(
        id: String,
        name: String,
        digits: String,
        color: String,
        isPrimary: Bool
    ) {
        self.id = id
        self.name = name
        self.digits = digits
        self.color = color
        self.isPrimary = isPrimary
    }
}
