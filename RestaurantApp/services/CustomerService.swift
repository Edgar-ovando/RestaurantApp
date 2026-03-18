//
//  CustomerService.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 16/03/26.
//

import Foundation
import UIKit

final class CustomerService {
    
    static let shared = CustomerService()
    
    // Gateway API
    static let baseURL = "http://localhost:8085/api/customers"
    
    func postCustomer(customer: Customer, completed: @escaping (Result<[Customer], myError>) -> Void) {
        
        guard let url = URL(string: Self.baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encodedCustomer = try JSONEncoder().encode(customer)
            request.httpBody = encodedCustomer
        } catch {
            completed(.failure(.invalidData))
            return
        }
        
        
        // Manejo de Status Code para el POST
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let _ = error {
                completed(.failure(.unabletoComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let customers = try JSONDecoder().decode([Customer].self, from: data)
                completed(.success(customers))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }.resume()
    }
}
