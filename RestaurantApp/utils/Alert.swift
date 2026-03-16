//
//  Alert.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 09/12/25.
//

import Foundation
import SwiftUI



struct AlertItem: Identifiable{
    let id = UUID()
    let title:Text
    let message:Text
    let dismissButton: Alert.Button
}

struct AlertContext{
    
    static let invalidData = AlertItem(title: Text("Server Error"),
                                              message: Text("The data received from the server was invalid. Please contact support."),
                                              dismissButton: .default(Text("Ok")))
    
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                              message: Text("Invalid Response from the server. Please try again later or contact support."),
                                              dismissButton: .default(Text("Ok")))
    
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                              message: Text("Issue connecting to the server. Please try again later or contact support."),
                                              dismissButton: .default(Text("Ok")))
    
    static let unabletoComplete = AlertItem(title: Text("Server Error"),
                                              message: Text("Unable to complete your request at this time. Please check your internet connection and try again."),
                                              dismissButton: .default(Text("Ok")))
    
    static let passwordMismatch = AlertItem(title: Text("Error"),
                                            message: Text("Passwords do not match."),
                                            dismissButton: .default(Text("Ok")))
        
    
    static let registrationSuccess = AlertItem(title: Text("Success"),
                                               message: Text("Customer registered successfully!"),
                                               dismissButton: .default(Text("Ok")))
 

    
    
}
