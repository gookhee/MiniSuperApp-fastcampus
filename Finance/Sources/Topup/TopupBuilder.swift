//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs
import FinanceRepository
import CombineUtil
import FinanceEntity
import AddPaymentMethod

public protocol TopupDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    /// Topup 리블렛이 소유하는 VC가 아니고, Topup 리블렛을 띄운? (attatch한?) 리블렛이 지정한 VC
    /// Topup에서 어떤 화면을 띄우고 싶을 때
    var topupBaseViewController: TopupBaseViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var superPayRepository: SuperPayRepositoryAvailable { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, AddPaymentMethodDependency, EnterAmountDependency, CardOnFileDependency {
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var topupBaseViewController: TopupBaseViewControllable {
        return dependency.topupBaseViewController
    }

    let paymentMethodStream: CurrentValuePublisher<PaymentMethod>

    init(
        dependency: TopupDependency,
        paymentMethodStream: CurrentValuePublisher<PaymentMethod>
    ) {
        self.paymentMethodStream = paymentMethodStream
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    public override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TopupListener) -> Routing {
        let paymentMethodStream = CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
        let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
        let interactor = TopupInteractor(dependency: component)
        interactor.listener = listener
        let addPaymentMethodBuilder = AddPaymentMethodBuilder(dependency: component)
        let enterAmountBuilder = EnterAmountBuilder(dependency: component)
        let cardOnFileBuilder = CardOnFileBuilder(dependency: component)

        return TopupRouter(
            interactor: interactor,
            viewController: component.topupBaseViewController,
            addPaymentMethodBuildable: addPaymentMethodBuilder,
            enterAmountBuildable: enterAmountBuilder,
            cardOnFileBuildable: cardOnFileBuilder
        )
    }
}

