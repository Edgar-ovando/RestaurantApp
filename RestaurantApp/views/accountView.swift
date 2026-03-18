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
    @State private var hidePassword: Bool = true
    
    
    // FocusState para manejar teclado
    enum Field: Hashable {
        case email, password
    }
    
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        
        ZStack {
            
            NavigationStack{
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        if !message.isEmpty {
                            Text(message)
                                .foregroundColor(.red)
                        }
                        
                        
                        // Email field
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .email)
                            .frame(height: 25)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        // Password field
                        HStack {
                            if hidePassword {
                                SecureField("Password", text: $password)
                                    .focused($focusedField, equals: .password)
                            } else {
                                TextField("Password", text: $password)
                                    .focused($focusedField, equals: .password)
                            }
                            
                            Button(action: {
                                hidePassword.toggle()
                            }) {
                                Image(systemName: hidePassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(height: 55)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
        
                        
                        // Forgot password
                        HStack {
                            Spacer()
                            Text("Forgot your password?")
                                .font(.footnote)
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
                        } .navigationTitle("👤 Account")
                        
                        // Sign Up
                        HStack {
                            Text("Don't have an account?")
                                .foregroundColor(.gray)
                            
                            NavigationLink {
                                RegisterView()
                                
                            }label: {
                                Text("Sign Up")
                            }
                            .foregroundColor(Color.brand)
                        }
                        .padding(.top,30)
                        
                        // OR Divider
                        HStack {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.gray.opacity(0.3))
                            
                            Text("OR")
                                .foregroundColor(.gray)
                                .font(.footnote)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.gray.opacity(0.3))
                        }
                        .padding(.vertical)
                        
                        // Social Buttons
                        HStack(spacing: 35) {
                            Button(action: {}) {
                                Image("facebook")
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                            
                            Button(action: {}) {
                                Image("google")
                                    .font(.title)
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: {}) {
                                Image("twitter")
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal, 25)
                    .padding(.top,40)
                    
                }
                // TapGesture para cerrar teclado al tocar fuera
                .onTapGesture {
                    focusedField = nil
                }

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
