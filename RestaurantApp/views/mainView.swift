//
//  footerView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 19/11/25.
//

import SwiftUI

struct mainView: View {
    var body: some View {
        TabView{
            appetizerView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            accountView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Account")
                }
            orderView()
                .tabItem{
                    Image(systemName: "bag")
                    Text("Order")
                }
        }
        .accentColor(Color("brandColor"))

    }
}

#Preview {
    mainView()
}
