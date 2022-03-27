//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs
import UIKit
import AddPaymentMethod
import RIBsUtil
import FinanceEntity
import Topup

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    private var navigationController: UINavigationController?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildingLogic
    private var addPaymentMethodRouting: UIViewController?
    
    private let enterAmountBuildable: EnterAmountBuildingLogic
    private var enterAmountRouting: UIViewController?
    
    private let cardOnFileBuildable: CardOnFileBuildingLogic
    private var cardOnFileRouting: UIViewController?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: TopupInteractable,
        viewController: TopupBaseViewControllable,
        addPaymentMethodBuildable: AddPaymentMethodBuildingLogic,
        enterAmountBuildable: EnterAmountBuildingLogic,
        cardOnFileBuildable: CardOnFileBuildingLogic
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        self.cardOnFileBuildable = cardOnFileBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
        guard
            nil != viewController.uiviewController.presentedViewController,
            nil != navigationController
        else { return }
        
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - Private
    
    private let viewController: TopupBaseViewControllable
    
    func attachAddPaymentMethod(closeButtonType: DismissButtonType) {        
        guard nil == addPaymentMethodRouting else { return }
        
        let destination = addPaymentMethodBuildable.build(listener: interactor, closeButtonType: .close)
        
        if let navigationController = navigationController {
            navigationController.pushViewController(destination, animated: true)
        } else {
            presentInsideNavigation(destination)
        }

        addPaymentMethodRouting = destination
    }
    
    func detachAddPaymentMethod() {
        guard nil == addPaymentMethodRouting else { return }
        
        navigationController?.popViewController(animated: true)
        
        addPaymentMethodRouting = nil
    }
    
    func attachEnterAmount() {
        guard nil == enterAmountRouting else { return }
        
        let viewController = enterAmountBuildable.build(withListener: interactor)
        
        if let navigationController = navigationController {
            /// 첫화면 카드 추가 -> 카드 추가 후
            navigationController.setViewControllers([viewController], animated: true)
            resetChildRouting()
        } else {
            /// 첫 화면이 충전하기
            presentInsideNavigation(viewController)
        }
        
        enterAmountRouting = viewController
    }
    
    func detachEnterAmount() {
        guard nil != enterAmountRouting else { return }
        
        dismissPresentedNavigation(completion: nil)
        
        enterAmountRouting = nil
    }
    
    func attachCardOnFile(paymentMethods: [PaymentMethod]) {
        guard nil == cardOnFileRouting else { return }
        
        let viewConroller = cardOnFileBuildable.build(listener: interactor, paymentMethods: paymentMethods)
        navigationController?.pushViewController(viewConroller, animated: true)
        cardOnFileRouting = viewConroller
    }
    
    func detachCardOnFile() {
        guard nil != cardOnFileRouting else { return }
        
        navigationController?.popViewController(animated: true)
        cardOnFileRouting = nil
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
        resetChildRouting()
    }
}

// MARK: - private

extension TopupRouter {
    private func presentInsideNavigation(_ viewControllable: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewControllable)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.backgroundColor = .white
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        self.navigationController = navigationController
        navigationController.presentationController?.delegate = viewController.presentationDelegate
        viewController.uiviewController.present(navigationController, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        guard nil != navigationController else { return }
        
        viewController.dismiss(completion: completion)
        navigationController = nil
    }
    
    private func resetChildRouting() {
        if nil != cardOnFileRouting {
            cardOnFileRouting = nil
        }
        
        if nil != addPaymentMethodRouting {
            addPaymentMethodRouting = nil
        }
    }
}
