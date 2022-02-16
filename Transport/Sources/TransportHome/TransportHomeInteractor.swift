import ModernRIBs
import Combine
import Foundation
import CombineUtil
import FoundationExt

protocol TransportHomeRouting: ViewableRouting {
    func attachTopup()
    func detachTopup()
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ balance: String)
    func setRidePrice(_ ridePrice: String)
}

public protocol TransportHomeListener: AnyObject {
    func transportHomeDidTapClose()
}

protocol TransportHomeInteractorDependency {
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {
    
    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?
    private let dependency: TransportHomeInteractorDependency
    
    /// 강의 범위가 아니여서 하드코딩
    private let ridePrice: Double = 19000
    
    private var cancellables: Set<AnyCancellable>
    init(
        presenter: TransportHomePresentable,
        dependency: TransportHomeInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let ridePriceText = Formatter.balanceFormatter.string(from: .init(value: ridePrice)) {
            presenter.setRidePrice(ridePriceText)
        }
        dependency.superPayBalance
            .receive(on: DispatchQueue.main)
            .sink {[weak self] balance in
                if let balanceText = Formatter.balanceFormatter.string(from: .init(value: balance)) {
                    self?.presenter.setSuperPayBalance(balanceText)
                }
            }
            .store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }
    
    func listenToRideConfirmButtonTapped() {
        if dependency.superPayBalance.value < ridePrice {
            router?.attachTopup()
        } else {
            /// 강의 범위 X
            print("success")
        }
    }
    
    // MARK: - TopupBaseViewControllable
    
    func listenToScreenDismissed() {
        router?.detachTopup()
    }
    
    // MARK: - TopupListener
    
    func listenToTopupClosed() {
        router?.detachTopup()
    }
    
    func listenToTopupFinished() {
        router?.detachTopup()
    }
}
