//
//  RestaurantAppApp.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 19/11/25.
//

import SwiftUI

@main
struct RestaurantApp: App {
    
    @StateObject var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
    }

}

struct RootView: View {
    
    @EnvironmentObject var session: SessionManager
    
    var body: some View {
        if session.isLoggedIn {
            mainView()
        } else {
            LoginView()
        }
    }
}
