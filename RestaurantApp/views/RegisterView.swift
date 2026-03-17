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
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var hidePassword: Bool = true
    
    @State private var customer: Customer?
    @State private var alertItem: AlertItem?
    @State var isLoading = false
    
    //PhoneData
    @State private var selectedCountry: Country = countries.first!
    @State private var showPicker = false
    
    var fullNumber: String {
        "\(selectedCountry.dialCode) \(phone)"
    }
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // Name
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                        TextField("Name", text: $name)
                            .textContentType(.name)
                            .textInputAutocapitalization(.words)
                    }
                    .modifier(InputField())
                    
                    // Email
                    HStack {
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
                    
                    VStack() {
                        
                        HStack() {
                            
                            // Selector de país
                            Button {
                                showPicker = true
                            } label: {
                                HStack() {
                                    Text(selectedCountry.flag)
                                    
                                    Text(selectedCountry.dialCode)
                                        .foregroundColor(.primary)
                                    
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                                .frame(height: 20)
                            
                            // Input
                            TextField("Phone number", text: $phone)
                                .keyboardType(.phonePad)
                        }
                        
                    }
                    .modifier(InputField())
                    .sheet(isPresented: $showPicker) {
                        CountryPickerView(selectedCountry: $selectedCountry)
                    }
                    
                 
                    
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
                        Button { hidePassword.toggle() } label: {
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
                        Button { hidePassword.toggle() } label: {
                            Image(systemName: hidePassword ? "eye.slash" : "eye")
                                .foregroundStyle(.gray)
                        }
                    }
                    .modifier(InputField())
                    
                    // Register Button
                    Button {
                        createCustomer()
                    } label: {
                        Text("Create Account")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, minHeight: 65)
                            .background(Color.brand)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.top, 25)
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
            }
            .navigationTitle("Register")
            .alert(item: $alertItem) { alertItem in
                
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
        }
        
    }
    
    // MARK: - Post Customer
    func createCustomer() {
        
        isLoading = true
        print("Number: ", phone)
        
        
        // Validar passwords
        guard password == confirmPassword else {
            alertItem = AlertContext.passwordMismatch
            return
        }
        
        let newCustomer = Customer(
            id: UUID(),
            name: name,
            email: email,
            phone: phone,
            password: password,
            address: "Not Provided",
            city: "Not Provided"
        )
        
        CustomerService.shared.postCustomer(customer: newCustomer) { result in
            
            DispatchQueue.main.async {
                
                isLoading = false
                
                switch result {
                
                
                case .success(let customers):
                    
                    // Normalmente devuelve un solo Customer, puedes usar customers.first
                    self.customer = customers.first
                    alertItem = AlertContext.registrationSuccess
                    
                case .failure(let error):
                    switch error {
                    
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unabletoComplete:
                        alertItem = AlertContext.unabletoComplete
                    }
                }

            }
        }
    }
    
}


// MARK: - Input Field Modifier
struct InputField: ViewModifier {
    func body(content: Content) -> some View {
        content .padding() .frame(height: 65) .background( RoundedRectangle(cornerRadius: 14) .fill(Color(.systemGray6)) )
    }
}



#Preview {
    RegisterView()
}
