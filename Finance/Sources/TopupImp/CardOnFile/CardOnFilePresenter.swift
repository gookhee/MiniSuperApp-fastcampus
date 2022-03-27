//
//  CardOnFilePresenter.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/27.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

import FinanceEntity

// MARK: - CardOnFilePresenter

final class CardOnFilePresenter {
    weak var viewController: CardOnFileDisplayLogic?
}

// MARK: - CardOnFilePresentationLogic

extension CardOnFilePresenter: CardOnFilePresentationLogic {
    
    func present(_ response: CardOnFile.Response) {
        switch response {
        case let .list(items):
            viewController?.display(
                CardOnFile.ViewModel.List(items: items.map{ .init($0) })
            )
        }
    }
}

// MARK: - CardOnFileDisplayLogic definition

protocol CardOnFileDisplayLogic: AnyObject {
    /// 외부매개변수는 제외하기
    func display(_ viewModel: CardOnFile.ViewModel.List)
}
