//
//  UserViewModel.swift
//  MVVMSample
//
//  Created by Javier Calatrava on 18/1/26.
//

import Foundation

class UserListViewModel {
    private var users: [User] = []
    
    var onDataUpdate: (() -> Void)?
    
    // Lógica para la tabla
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(at index: Int) -> User {
        return users[index]
    }
    
    func fetchUsers() {
        // Simulando carga de API
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.users = [
                User(name: "Alice", email: "alice@example.com"),
                User(name: "Bob", email: "bob@example.com"),
                User(name: "Charlie", email: "charlie@example.com")
            ]
            self.onDataUpdate?()
        }
    }
}
