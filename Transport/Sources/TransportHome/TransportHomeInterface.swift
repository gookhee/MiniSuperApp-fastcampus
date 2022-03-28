//
//  TransportHomeInterface.swift
//  
//
//  Created by 정국희 on 2022/02/16.
//

import UIKit

// MARK: - TransportHomeBuildingLogic definition

public protocol TransportHomeBuildingLogic {
    typealias Destination = UIViewController
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func build(withListener listener: TransportHomeListener) -> Destination
}


public protocol TransportHomeListener: AnyObject {
    func transportHomeDidTapClose()
}

