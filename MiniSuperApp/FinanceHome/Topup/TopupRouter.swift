//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs
import UIKit

protocol TopupInteractable: Interactable, AddPaymentMethodListener, EnterAmountListener, CardOnFileListener {
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
}

protocol TopupBaseViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    var presentationDelegate: UIAdaptivePresentationControllerDelegate { get }
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    
    private var navigationControllerable: NavigationControllerable?
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private var addPaymentMethodRouting: Routing?
    
    private let enterAmountBuildable: EnterAmountBuildable
    private var enterAmountRouting: Routing?
    
    private let cardOnFileBuildable: CardOnFileBuildable
    private var cardOnFileRouting: Routing?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: TopupInteractable,
        viewController: TopupBaseViewControllable,
        addPaymentMethodBuildable: AddPaymentMethodBuildable,
        enterAmountBuildable: EnterAmountBuildable,
        cardOnFileBuildable: CardOnFileBuildable
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
            nil != navigationControllerable
        else { return }
        
        navigationControllerable?.dismiss(completion: nil)
    }
    
    // MARK: - Private
    
    private let viewController: TopupBaseViewControllable
    
    func attachAddPaymentMethod(closeButtonType: DismissButtonType) {
        guard nil == addPaymentMethodRouting else { return }
        
        let router = addPaymentMethodBuildable.build(
            withListener: interactor,
            closeButtonType: closeButtonType
        )
        
        if let navigationControllerable = navigationControllerable {
            navigationControllerable.pushViewController(router.viewControllable, animated: true)
        } else {
            presentInsideNavigation(router.viewControllable)
        }
        addPaymentMethodRouting = router
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        guard let router = addPaymentMethodRouting else { return }
        
        navigationControllerable?.popViewController(animated: true)
        
        detachChild(router)
        addPaymentMethodRouting = nil
    }
    
    func attachEnterAmount() {
        guard nil == enterAmountRouting else { return }
        
        let router = enterAmountBuildable.build(withListener: interactor)
        
        if let navigationControllerable = navigationControllerable {
            navigationControllerable.setViewControllers([router.viewControllable])
            resetChildRouting()
        } else {
            presentInsideNavigation(router.viewControllable)
        }
        
        enterAmountRouting = router
        attachChild(router)
    }
    
    func detachEnterAmount() {
        guard let router = enterAmountRouting else { return }
        
        dismissPresentedNavigation(completion: nil)
        
        detachChild(router)
        enterAmountRouting = nil
    }
    
    func attachCardOnFile(paymentMethods: [PaymentMethod]) {
        guard nil == cardOnFileRouting else { return }
        
        let router = cardOnFileBuildable.build(withListener: interactor, paymentMethods: paymentMethods)
        navigationControllerable?.pushViewController(router.viewControllable, animated: true)
        attachChild(router)
        cardOnFileRouting = router
    }
    
    func detachCardOnFile() {
        guard let router = cardOnFileRouting else { return }
        
        navigationControllerable?.popViewController(animated: true)
        detachChild(router)
        cardOnFileRouting = nil
    }
    
    func popToRoot() {
        navigationControllerable?.popViewController(animated: true)
        resetChildRouting()
    }
}

// MARK: - private

extension TopupRouter {
    private func presentInsideNavigation(_ viewControllable: ViewControllable) {
        let navigationControllerable = NavigationControllerable(root: viewControllable)
        navigationControllerable.navigationController.presentationController?.delegate = viewController.presentationDelegate
        self.navigationControllerable = navigationControllerable
        viewController.present(navigationControllerable, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        guard nil != navigationControllerable else { return }
        
        viewController.dismiss(completion: completion)
        navigationControllerable = nil
    }
    
    private func resetChildRouting() {
        if let routing = addPaymentMethodRouting {
            detachChild(routing)
            addPaymentMethodRouting = nil
        }
        
        if let routing = cardOnFileRouting {
            detachChild(routing)
            cardOnFileRouting = nil
        }
    }
}
