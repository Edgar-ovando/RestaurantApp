//
//  LoginView.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 18/03/26.
//

import SwiftUI

struct LoginView: View {
    
    // Variable de Sesion Login
    @EnvironmentObject var session: SessionManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var hidePassword: Bool = true
    
    //Loading Circle
    @State private var isLoading: Bool = false
    
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
                        Button {
                            login()
                        } label: {
                            
                            Text("Login")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.brand)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
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
                    .navigationTitle("Login")
                    .padding(.horizontal, 25)
                    .padding(.top,40)
                    
                }
                // TapGesture para cerrar teclado al tocar fuera
                .onTapGesture {
                    focusedField = nil
                }

            }
            
            if isLoading {
                LoadingView()
            }
        }
    }
    
    func login() {
        
        
        isLoading = true
        
        // Validamos que los campos no estén vacíos
        if email.isEmpty || password.isEmpty {
            isLoading = false
            message = "Please fill all fields"
            return // Salimos de la función si falta información
        }
        
        // Creamos una tarea asíncrona porque vamos a usar await
        Task {
            do {
                
                // Llamamos al servicio de login enviando email y password
                // Si las credenciales son correctas, devuelve un Customer
                let customer = try await CustomerService.shared.loginCustomer(email: email, password: password)
                
                // Debug: imprimimos el nombre del usuario en consola
                print("Bienvenido \(customer.name)")
                
                // Actualizamos la UI en el hilo principal (MainActor)
                await MainActor.run {
                    message = ""          // Limpiamos mensaje de error
                    session.login()       // Marcamos sesión como iniciada
                    isLoading = false
                }
                
            } catch {
                
                // Si ocurre un error (credenciales incorrectas o fallo de red)
                await MainActor.run {
                    message = "Invalid credentials"
                    isLoading = false
                }
            }
          
        }
    }
    
}

#Preview {
    LoginView()
}
