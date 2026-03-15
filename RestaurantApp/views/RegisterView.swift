//
//  RegisterView.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 14/03/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var hidePassword: Bool = true
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                
                ScrollView {
                    
                    VStack{
                        
                        // User Form
                        VStack (spacing: 25) {
                            
                            HStack {
    
                                // Name
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                
                                TextField("Name", text: $name)
                                    .textContentType(.name)
                                    .textInputAutocapitalization(.words)
                                   
                                
                            } .modifier(InputField())
 
                            
                            // Email
                            HStack{
                                
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                
                                TextField("Email", text: $email)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .textContentType(.emailAddress)
                                
                                
                            }
                            .modifier(InputField())
                            

                            
                            // Phone
                            TextField("Phone number", text: $phoneNumber)
                                .keyboardType(.phonePad)
                                .textContentType(.telephoneNumber)
                                .modifier(InputField())
                            
                            
                            // Password
                            HStack {
                                
                                Group {
                                    if hidePassword {
                                        Image(systemName: "lock")
                                            .foregroundColor(.gray)
                                        SecureField("Password", text: $password)
                                    } else {
                                        Image(systemName: "lock")
                                            .foregroundColor(.gray)
                                        TextField("Password", text: $password)
                                    }
                                }
                                
                                Button {
                                    hidePassword.toggle()
                                } label: {
                                    Image(systemName: hidePassword ? "eye.slash" : "eye")
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                            .modifier(InputField())
                            
                            
                            // Confirm Password
                            HStack {
                                
                                Group {
                                    if hidePassword {
                                        Image(systemName: "lock")
                                            .foregroundColor(.gray)
                                        SecureField("Confirm Password", text: $confirmPassword)
                                    } else {
                                        Image(systemName: "lock")
                                            .foregroundColor(.gray)
                                        TextField("Confirm Password", text: $confirmPassword)
                                    }
                                }
                                
                                Button {
                                    hidePassword.toggle()
                                } label: {
                                    Image(systemName: hidePassword ? "eye.slash" : "eye")
                                        .foregroundStyle(.gray)
                                }
                                
                            }
                            .modifier(InputField())
              
                        }
                        
                        // Mark: Register Button
                        Button {
                            
                        } label: {
                            Text("Create Account")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 65)
                                .background(Color.brand)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .padding(.top,25)
                     
                    }
                    .padding(.top, 40)
                    .padding(.horizontal,24)
                                    
                }
                .navigationTitle(Text("Register"))
            }
        }
       
    }
}


struct InputField: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 65)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
            )
    }
}




#Preview {
    RegisterView()
}
