//
//  UserViewModel.swift
//  MVVMSample
//
//  Created by Javier Calatrava on 18/1/26.
//

import RxSwift
import RxRelay

class UserListViewModel {
    // Relay que contiene la lista de usuarios (empieza vacío)
    // Usamos Relay porque no emite errores y no termina la secuencia
    private let usersRelay = BehaviorRelay<[User]>(value: [])
    
    // Exponemos el relay como un Observable para que la View no pueda modificarlo
    var users: Observable<[User]> {
        return usersRelay.asObservable()
    }
    
    func fetchUsers() {
        // Simulamos petición de red
        let mockData = [
            User(name: "Alice", email: "alice@example.com"),
            User(name: "Bob", email: "bob@example.com"),
            User(name: "Charlie", email: "charlie@example.com")
        ]
        
        // "Empujamos" los nuevos datos al stream
        usersRelay.accept(mockData)
    }
}
