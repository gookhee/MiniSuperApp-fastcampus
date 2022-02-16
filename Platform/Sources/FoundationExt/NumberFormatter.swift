//
//  NumberFormatter.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import Foundation

public struct Formatter {
    public static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
