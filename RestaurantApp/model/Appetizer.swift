//
//  Appetizer.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 24/11/25.
//

import Foundation


struct Appetizer: Decodable, Identifiable{
    
    let id: UUID
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let protein: Int
    let carbs: Int
        
}
// Solo en caso de que el JSON este en un request array
/*
struct AppetizerResponse: Decodable{
    let request:[Appetizer]
}*/

struct MockData{
    static let sampleAppetizer = Appetizer(id: UUID(),
                                           name: "Test Appetizer",
                                           description: "This is the description for Mock Data",
                                           price: 9.99,
                                           imageURL: "",
                                           calories: 99,
                                           protein: 99,
                                           carbs: 99)
    
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer, sampleAppetizer]
}
