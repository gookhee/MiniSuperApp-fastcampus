//
//  UIViewController+Utils.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/18.
//

import UIKit

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

extension UIViewController {
    func setupNavigationItem(with buttonType: DismissButtonType, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = .init(
            image: .init(systemName: buttonType.iconSystemName),
            style: .plain,
            target: self,
            action: action
        )
    }
}
