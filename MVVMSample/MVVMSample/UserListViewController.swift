//
//  ViewController.swift
//  MVVMSample
//
//  Created by Javier Calatrava on 18/1/26.
//

import UIKit
import RxSwift
import RxCocoa

class UserListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = UserListViewModel()
    private let disposeBag = DisposeBag()
    private let cellId = "UserCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchUsers()
    }
    
    private func setupBindings() {
        viewModel.users
            .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: UITableViewCell.self)) { (row, user, cell) in
                var content = cell.defaultContentConfiguration()
                content.text = user.name
                content.secondaryText = user.email
                cell.contentConfiguration = content
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(User.self)
            .subscribe(onNext: { user in
                print("Usuario seleccionado: \(user.name)")
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        title = "Usuarios Rx"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
