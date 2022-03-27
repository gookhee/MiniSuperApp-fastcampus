//
//  CardOnFileViewController.swift
//  MiniSuperApp
//
//  Created by 정국희 on 2022/03/27.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

// MARK: - CardOnFileViewController

final class CardOnFileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var items: [CardOnFile.ViewModel.Item] = []
    
    var interactor: CardOnFileRequestLogic?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        interactor?.process(CardOnFile.Request.OnLoad())
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: CardOnFileCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private func setupViews() {
        title = "카드 선택"
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        setupNavigationItem(with: .back, target: self, action: #selector(didTapClose))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CardOnFileCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let viewModel = items[safe: indexPath.row] {
            cell.setImage(UIImage(color: viewModel.color))
            cell.setTitle("\(viewModel.name) \(viewModel.digits)")
        } else {
            cell.setImage(UIImage(systemName: "plus.rectangle"))
            cell.setTitle("카드 추가")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        interactor?.process(CardOnFile.Request.OnItem(index: indexPath.row))
    }
    
    @objc
    private func didTapClose() {
        interactor?.process(CardOnFile.Request.OnClose())
    }
}

// MARK: - CardOnFileDisplayLogic

extension CardOnFileViewController: CardOnFileDisplayLogic {
    
    func display(_ viewModel: CardOnFile.ViewModel.List) {
        self.items = viewModel.items
        tableView.reloadData()
    }
}
