//
//  PhoneNumberField.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 15/03/26.
//
import SwiftUI
import PhoneNumberKit

struct PhoneNumberField: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> PhoneNumberTextField {
        let textField = PhoneNumberTextField()
        
        // Mostrar bandera
        textField.withFlag = true
        
        // NO mostrar prefijo en el textfield
        textField.withPrefix = true
        
        // Ejemplo de numero aleatorio desactivado
        textField.withExamplePlaceholder = false
        
        // Placeholder correcto
        textField.placeholder = " Phone number"
        
        // Teclado de teléfono
        textField.keyboardType = .phonePad
        
        
        textField.addTarget(
            context.coordinator,
            action: #selector(Coordinator.textChanged),
            for: .editingChanged
        )
        
        return textField
    }
    
    func updateUIView(_ uiView: PhoneNumberTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        
        var parent: PhoneNumberField
        
        init(_ parent: PhoneNumberField) {
            self.parent = parent
        }
        
        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
        }
    }
}
