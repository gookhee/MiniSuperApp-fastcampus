//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/01/16.
//

import ModernRIBs
import UIKit
import RIBsUtil
import SuperUI

protocol AddPaymentMethodPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapClose()
    func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
    
    weak var listener: AddPaymentMethodPresentableListener?
    
    private lazy var cardNumberTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "카드 번호"
        return view
    }()
    
    private lazy var securityTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "CVC"
        return view
    }()
    
    private lazy var expirationTextField: UITextField = {
        let view = makeTextField()
        view.placeholder = "유효기간"
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.spacing = 14
        return view
    }()
    
    private lazy var addCardButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners()
        view.backgroundColor = .primaryRed
        view.setTitle("추가하기", for: .normal)
        view.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
        return view
    }()
    
    init(closeButtonType: DismissButtonType) {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupNavigationItem(with: closeButtonType, target: self, action: #selector(didTapClose))
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        setupNavigationItem(with: .close, target: self, action: #selector(didTapClose))
    }
}

extension AddPaymentMethodViewController {
    private func setupViews() {
        title = "카드 추가"
        
        view.backgroundColor = .backgroundColor
        view.addSubview(cardNumberTextField)
        view.addSubview(stackView)
        view.addSubview(addCardButton)
        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextField)
        
        NSLayoutConstraint.activate([
            cardNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cardNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            cardNumberTextField.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -20),
            securityTextField.heightAnchor.constraint(equalToConstant: 60),
            expirationTextField.heightAnchor.constraint(equalToConstant: 60),
            
            addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            addCardButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func makeTextField() -> UITextField {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.borderStyle = .roundedRect
        view.keyboardType = .numberPad
        return view
    }
    
    @objc
    private func didTapAddCard() {
        if
            let number = cardNumberTextField.text,
            let cvc = securityTextField.text,
            let expiry = expirationTextField.text {
            listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
        }
    }
    
    @objc
    private func didTapClose() {
        listener?.didTapClose()
    }
}
