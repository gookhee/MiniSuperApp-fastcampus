//
//  SuperPayRepository.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/19.
//

import Foundation
import Combine
import CombineUtil

public protocol SuperPayRepositoryAvailable {
    var balance: ReadOnlyCurrentValuePublisher<Double> { get }
    func topup(
        amount: Double,
        paymentMethodID: String
    ) -> AnyPublisher<Void, Error>
}

public final class SuperPayRepository: SuperPayRepositoryAvailable {
    public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }

    private let balanceSubject = CurrentValuePublisher<Double>(0)
    private let bgQueue = DispatchQueue(label: "topup.repository.queue")

    public init() {}
    
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> {[weak self] promise in
            self?.bgQueue.async {
                Thread.sleep(forTimeInterval: 2)
                promise(.success(()))
                if let newBalance = (self?.balanceSubject.value).map({ $0 + amount }) {
                    self?.balanceSubject.send(newBalance)
                }
            }
        }
        .eraseToAnyPublisher()
    }

}
