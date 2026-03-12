//
//  accountView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 19/11/25.
//

import SwiftUI

struct accountView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var message: String = ""

    var body: some View {
        
        ZStack {
     
            NavigationStack{
     
                VStack(spacing: 20) {
                    
                    Spacer()
                        .frame(height: 40)
                    
                    
                    if !message.isEmpty {
                        Text(message)
                            .foregroundColor(.red)
                    }
                    
                    
                    // Email field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .frame(height: 25)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    // Password field
                    SecureField("Password", text: $password)
                        .frame(height: 25)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    // Forgot password
                    HStack {
                        Spacer()
                        Text("Forgot your password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.brand)
                    }
                    
                    // Login button
                    Button(action: login) {
                        Text("Login")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.brand)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .navigationTitle("👤 Account")
                    
                    Spacer()
                    
               
                    
                }
                .padding(15)
                .background(Color.white.opacity(0.9))
                .cornerRadius(40)
                .padding(.horizontal, 25)
            }
        }
 
        
        
    } // End View
    
    func login() {
        if email.isEmpty || password.isEmpty {
            message = "Please fill all fields"
            return
        }
        
        // Simulated login logic
        if email == "test@email.com" && password == "123456" {
            message = "Login successful"
        } else {
            message = "Invalid credentials"
        }
    }
    
    
}



#Preview {
    accountView()
}
