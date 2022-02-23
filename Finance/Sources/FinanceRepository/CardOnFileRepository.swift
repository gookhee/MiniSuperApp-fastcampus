//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2021/12/15.
//

import Foundation
import Combine
import CombineUtil
import FinanceEntity

/// 서버 API를 호출하여 유저에게 등록됨 카드 리스트를 받아옴
public protocol CardOnFileRepositoryAvailable {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
}

public final class CardOnFileRepository: CardOnFileRepositoryAvailable {
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }

    /// 서버 접근 대신 더미데이터 전달
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
//    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//    PaymentMethod(id: "1", name: "신한카드", digits: "0987", color: "#3478f6ff", isPrimary: false),
//    PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false),
//    PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c466ff", isPrimary: false),
//    PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false)
  ])

    public init() {}
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let paymentMethod = PaymentMethod(
            id: "00",
            name: "NewCard",
            digits: "\(info.number.suffix(4))",
            color: "",
            isPrimary: false
        )

        var new = paymentMethodsSubject.value
        new.append(paymentMethod)
        paymentMethodsSubject.send(new)

        return Just(paymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
