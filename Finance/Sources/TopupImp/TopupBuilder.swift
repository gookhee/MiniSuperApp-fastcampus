//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs
import FinanceRepository
import CombineUtil
import AddPaymentMethod
import FinanceEntity
import Topup

public protocol TopupDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
    var superPayRepository: SuperPayRepositoryAvailable { get }
    var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic { get }
}

final class TopupComponent: Component<TopupDependency>, TopupInteractorDependency, EnterAmountDependency, CardOnFileDependency {
    var superPayRepository: SuperPayRepositoryAvailable { dependency.superPayRepository }
    var cardOnFileRepository: CardOnFileRepositoryAvailable { dependency.cardOnFileRepository }
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { paymentMethodStream }
    var addPaymentMethodBuildable: AddPaymentMethodBuildingLogic { dependency.addPaymentMethodBuildable }

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

public final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    public override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TopupListener, topupBaseViewController: TopupBaseViewControllable) -> Routing {
        let paymentMethodStream = CurrentValuePublisher(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
        let component = TopupComponent(dependency: dependency, paymentMethodStream: paymentMethodStream)
        let interactor = TopupInteractor(dependency: component)
        interactor.listener = listener
        let enterAmountBuilder = EnterAmountBuilder(dependency: component)
        let cardOnFileBuilder = CardOnFileBuilder(dependency: component)

        return TopupRouter(
            interactor: interactor,
            viewController: topupBaseViewController,
            addPaymentMethodBuildable: component.addPaymentMethodBuildable,
            enterAmountBuildable: enterAmountBuilder,
            cardOnFileBuildable: cardOnFileBuilder
        )
    }
}

