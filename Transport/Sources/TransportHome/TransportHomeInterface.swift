//
//  TransportHomeInterface.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import Foundation
import ModernRIBs

public protocol TransportHomeBuildable: Buildable {
    func build(withListener listener: TransportHomeListener) -> ViewableRouting
}

public protocol TransportHomeListener: AnyObject {
    func transportHomeDidTapClose()
}

