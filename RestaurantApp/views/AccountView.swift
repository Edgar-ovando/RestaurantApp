//
//  accountView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 19/11/25.
//

import SwiftUI

struct AccountView: View {
    
    // Variable de Sesion Login
    @EnvironmentObject var session: SessionManager
    
    @State private var name: String = ""
    @State private var extraNapkins: Bool = false
    @State private var frequentRefill: Bool = false
    
    var body: some View {
        
        ZStack {
            
            NavigationStack {
                
                Form {
                    
                    // USER INFO
                    Section(header: Text("PERSONAL INFO")) {
                        
                        InfoRow(title: "Edgar Miguel Flores Ovando") {
                            print("Editar nombre")
                        }
                        
                        Text("Email")
                        
                        InfoRow(title: "Birthdate") {
                            print("Editar fecha")
                        }
                        
                    
                               
                        InfoRow(title: "Phone") {
                            print("Editar teléfono")
                        }
                        
                        InfoRow(title: "Address") {
                            print("Editar dirección")
                        }
                        
                        InfoRow(title: "City") {
                            print("Editar ciudad")
                        }
                    }
                    .foregroundColor(.gray)
                    .frame(minHeight: 25)
              
                   
                    // REQUESTS
                    Section(header: Text("REQUESTS")) {
                        
                        Toggle("Extra Napkins", isOn: $extraNapkins)
                           
                        Toggle("Frequent Refills", isOn: $frequentRefill)
                           
                        
                    }
                    
                    // Logout Button
                    
                    Button {
                        
                        logOut()
                        
                    } label: {
                        Text("Sign Out")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brand)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    
                }
               
                .navigationTitle("👤 Account")
                
            }
            
            
            
        }
   
    } // End View
    
    func logOut(){
        
        session.logout()
        
    }
    
    
    
} //End Struct

struct InfoRow: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Button {
                print("Tapped")

            } label :{
                Image(systemName: "square.and.pencil")
                    .font(.title2)
                    .foregroundColor(Color.brand)
                    .padding(8) // 👈 aumenta área táctil
            }
        }
    }
}


#Preview {
    AccountView()
}
