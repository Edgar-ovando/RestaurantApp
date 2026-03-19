//
//  RegisterView.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 14/03/26.
//
import SwiftUI

struct RegisterView: View {
    
    // MARK: - State
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var hidePassword: Bool = true
    @State private var confirmPassword: String = ""
    @State private var hideConfirmPassword: Bool = true
    @State private var customer: Customer?
    @State private var alertItem: AlertItem?
    
    
    @State var isLoading = false
    
    
    // Phone picker
    @State private var selectedCountry: Country = countries.first!
    @State private var showPicker = false
    
    // FocusState para manejar teclado
    enum Field: Hashable {
        case name, email, phone, password, confirmPassword
    }
    
    @FocusState private var focusedField: Field?
    
    // Número completo
    var fullNumber: String {
        "\(selectedCountry.dialCode)\(phone)"
    }
    
    var body: some View {
        
        ZStack {
            
            NavigationStack {
                
                ScrollView {
                    
                    VStack(spacing: 25) {
                        
                        // MARK: Name
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            TextField("Name", text: $name)
                                .textContentType(.name)
                                .textInputAutocapitalization(.never)
                                .focused($focusedField, equals: .name)
                        }
                        .modifier(InputField())
                        
                        
                        // MARK: Email
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .focused($focusedField, equals: .email)
                        }
                        .modifier(InputField())
                        
                        
                        // MARK: Phone
                        VStack {
                            HStack {
                                // Selector de país
                                Button {
                                    focusedField = nil // cierra teclado
                                    showPicker = true
                                } label: {
                                    HStack {
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
                                
                                TextField("Phone number", text: $phone)
                                    .keyboardType(.phonePad)
                                    .focused($focusedField, equals: .phone)
                            }
                        }
                        .modifier(InputField())
                        .sheet(isPresented: $showPicker) {
                            CountryPickerView(selectedCountry: $selectedCountry)
                        }
                        
                        
                        // MARK: Password
                        HStack {
                            
                            Group {
                                if hidePassword {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                    
                                    SecureField("Password", text: $password)
                                        .textContentType(.newPassword)
                                        .autocorrectionDisabled(true)
                                        .textInputAutocapitalization(.never)
                                        .focused($focusedField, equals: .password)
                                } else {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                    
                                    TextField("Password", text: $password)
                                        .textContentType(.newPassword)
                                        .autocorrectionDisabled(true)
                                        .textInputAutocapitalization(.never)
                                        .focused($focusedField, equals: .password)
                                }
                            }
                            
                            
                            Button(action: {
                                hidePassword.toggle()
                            }) {
                                Image(systemName: hidePassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                            
                            
                        }
                        .modifier(InputField())
                        
                        
                        // MARK: Confirm Password
                        HStack {
                            
                            Group {
                                if hideConfirmPassword {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                    SecureField("Confirm Password", text: $confirmPassword)
                                        .textContentType(.newPassword)
                                        .autocorrectionDisabled(true)
                                        .textInputAutocapitalization(.never)
                                        .focused($focusedField, equals: .confirmPassword)
                                }
                                else {
                                    Image(systemName: "lock")
                                        .foregroundColor(.gray)
                                    TextField("Confirm Password", text: $confirmPassword)
                                        .textContentType(.newPassword)
                                        .autocorrectionDisabled(true)
                                        .textInputAutocapitalization(.never)
                                        .focused($focusedField, equals: .confirmPassword)
                                }
                            }
                            
                            
                            Button(action: {
                                hideConfirmPassword.toggle()
                            }) {
                                Image(systemName: hideConfirmPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .modifier(InputField())
                        
                        
                        // MARK: Register Button
                        Button {
                            focusedField = nil // cierra teclado
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
                // TapGesture para cerrar teclado al tocar fuera
                .onTapGesture {
                    focusedField = nil
                }
            }
            
            if isLoading
            {
                LoadingView()
            }
            
            
        }
       
        
    }
    
    // MARK: - Post Customer
    func createCustomer() {
        
    
        isLoading = true  // Arrancamos el loading circle
    
        
        print("Number: ", fullNumber)
        
        // Validación de password
        guard password == confirmPassword else {
            alertItem = AlertContext.passwordMismatch
            isLoading = false
           
            return
        }
        
        let newCustomer = Customer(
            name: name,
            email: email,
            phone: fullNumber,
            password: password,
            address: "Not Provided",
            city: "Not Provided"
        )
        
        // Usamos Task para llamar a async function desde UI / MainActor
        Task {
            do {
                // Llamada a la función async
                let createdCustomer = try await CustomerService.shared.postCustomer(customer: newCustomer)
                
                // Como estamos en MainActor (Task por default hereda), podemos actualizar UI
                self.customer = createdCustomer
                alertItem = AlertContext.registrationSuccess
                
            } catch let error as myError {
                // Manejo de errores personalizado
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
            } catch {
                // Manejo de errores generales
                alertItem = AlertContext.unabletoComplete
            }
            
            // Se ejecuta siempre al final
            isLoading = false
            cleanForm()
           
        }
    }
    
    func cleanForm(){
        
        name = ""
        email = ""
        phone = ""
        password = ""
        confirmPassword = ""
        
        
        
    }
    
    
}

// MARK: - Input Field Modifier
struct InputField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(minHeight: 65)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
            )
    }
}

#Preview {
    RegisterView()
}
