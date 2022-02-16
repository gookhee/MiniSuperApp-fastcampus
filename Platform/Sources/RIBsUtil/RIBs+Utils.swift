//
//  DismissButtonType.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation

enum DismissButtonType {
    case back, close

    var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}
