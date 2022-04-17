//
//  DismissButtonType.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import UIKit

public enum DismissButtonType {
    case back, close

    public var iconSystemName: String {
        switch self {
        case .back:
            return "chevron.backward"
        case .close:
            return "xmark"
        }
    }
}
