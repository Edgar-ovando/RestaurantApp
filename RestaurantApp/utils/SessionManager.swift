//
//  SessionManager.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 19/03/26.
//

import Foundation
import Combine // Para que sirva ObservableObject

class SessionManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        checkSession()
    }
    
    func checkSession() {
        // Leer de UserDefaults (persistencia simple)
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func login() {
        isLoggedIn = true
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }
    
    func logout() {
        isLoggedIn = false
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}
