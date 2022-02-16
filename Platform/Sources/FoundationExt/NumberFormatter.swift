//
//  NumberFormatter.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
