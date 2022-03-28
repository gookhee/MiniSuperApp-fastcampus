//
//  AppRootInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/28.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation
import AppHome
import FinanceHome
import ProfileHome

// MARK: - AppRootInteractor

final class AppRootInteractor {
    var presenter: AppRootPresentationLogic?
    var router: AppRootRoutingLogic?
    private let worker: AppRootWorkingLogic
    private weak var listener: AppRootListener?

    /// 자유롭게 매개변수 추가하기. worker, listener 등등  (Add parameters freely. worker, listener, etc)
    init(
        worker: AppRootWorkingLogic,
        listener: AppRootListener?
    ) {
        self.worker = worker
        self.listener = listener
    }
}

// MARK: - AppHomeListener

extension AppRootInteractor: AppHomeListener {
    
}

// MARK: - FinanceHomeListener

extension AppRootInteractor: FinanceHomeListener {
    
}

// MARK: - ProfileHomeListener

extension AppRootInteractor: ProfileHomeListener {
    
}

// MARK: - AppRootRequestLogic

extension AppRootInteractor: AppRootRequestLogic {
    func process(_ request: AppRoot.Request.OnLoad) {
    }
}

// MARK: - AppRootRequestLogic definition

protocol AppRootRequestLogic {
    /// 외부매개변수는 제외하기
    func process(_ request: AppRoot.Request.OnLoad)
}

// MARK: - AppRootWorkingLogic definition

protocol AppRootWorkingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
    func doSomeWork()
}

// MARK: - AppRootPresentationLogic definition

protocol AppRootPresentationLogic {
    /// 외부매개변수는 제외하기
    func present(_ response: AppRoot.Response)
}

// MARK: - AppRootRoutingLogic definition

protocol AppRootRoutingLogic {
    /// 자유롭게 매개변수 추가하기 (Add parameters freely)
}

// MARK: - AppRootListener

public protocol AppRootListener: AnyObject {
}
