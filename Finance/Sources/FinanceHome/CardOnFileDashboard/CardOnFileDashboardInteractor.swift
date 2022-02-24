//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import ModernRIBs
import Combine
import FinanceRepository

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }

    func update(with methods: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func listenToAddPaymentMethodButtonPressed()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileRepositoryAvailable { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?

    private var cancellables: Set<AnyCancellable>

    private let dependency: CardOnFileDashboardInteractorDependency

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: CardOnFileDashboardPresentable,
        dependency: CardOnFileDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()


        dependency.cardOnFileRepository.cardOnFile.sink{ methods in
            /// 최대 5개 설정
            let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
            self.presenter.update(with: viewModels)

        }.store(in: &cancellables)
    }

    /// interactor가 detach 되기 직전에 불림
    /// 메모리 누수가 생기지 않으려면 sink에서 weak self를 사용하거나 여기서 cancellables를 비워줘도 됨.
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.

        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func didTapAddPaymentMethod() {
        listener?.listenToAddPaymentMethodButtonPressed()
    }
}
