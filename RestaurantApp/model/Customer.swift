//
//  Customer.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 16/03/26.
//

import Foundation

struct Customer: Codable, Identifiable {
    
    let id: UUID
    let name: String
    let email: String
    let phone: String
    let password: String
    let address: String
    let city: String
    
}
