//
//  CustomerService.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 16/03/26.
//

import Foundation   // Para URLSession, Codable y tipos de Foundation

// Declaramos una clase final, para que no pueda ser heredada
final class CustomerService {
    
    // Patrón Singleton: permite tener una sola instancia compartida en toda la app
    static let shared = CustomerService()
    
    // URL base de la API para clientes
    static let baseURL = "http://localhost:8085/api/customers"
    
    // MARK: - POST
    // Función para registrar un nuevo cliente en el backend
    // Es async porque usa async/await y puede lanzar errores
    func postCustomer(customer: Customer) async throws -> Customer {
        
        // Intentamos crear una URL válida a partir del string
        // Si falla, lanzamos un error custom
        guard let url = URL(string: Self.baseURL) else {
            throw myError.invalidURL
        }
        
        // Creamos un objeto URLRequest para configurar la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "POST"   // Indicamos que es una solicitud POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Tipo de contenido JSON
        
        // Convertimos nuestro objeto Customer en JSON para enviarlo al servidor
        // Si falla, el error se propaga hacia quien llame la función
        request.httpBody = try JSONEncoder().encode(customer)
        
        // Realizamos la solicitud de red usando async/await
        // URLSession.shared.data(for: request) devuelve los datos y la respuesta HTTP
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verificamos que la respuesta sea un HTTPURLResponse y que el status code sea 2xx (éxito)
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            // Si el status code no es exitoso, lanzamos un error
            throw myError.invalidResponse
        }
        
        // Decodificamos la respuesta JSON en un objeto Customer
        // Esto permite recibir de vuelta los datos del cliente creado, con ID generado por el backend, etc.
        return try JSONDecoder().decode(Customer.self, from: data)
    }
    
}
