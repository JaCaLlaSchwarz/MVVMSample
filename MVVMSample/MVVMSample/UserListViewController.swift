//
//  ViewController.swift
//  MVVMSample
//
//  Created by Javier Calatrava on 18/1/26.
//

import UIKit

class UserListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = UserListViewModel()
    private let cellId = "UserCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchUsers()
    }
    
    private func setupBindings() {
        viewModel.onDataUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        title = "Usuarios"
        view.addSubview(tableView)
        tableView.frame = view.bounds // O usa constraints
        
        // Configurar la tabla
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}

// MARK: - TableView DataSource
extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = viewModel.user(at: indexPath.row)
        
        // Configuramos la celda usando los datos procesados por el ViewModel
        var content = cell.defaultContentConfiguration()
        content.text = user.name
        content.secondaryText = user.email
        cell.contentConfiguration = content
        
        return cell
    }
}
