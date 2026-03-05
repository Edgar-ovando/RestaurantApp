//
//  NetworkManager.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 09/12/25.
//

import UIKit

final class NetworkManager{
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    //Gateway API 
    static let baseURL = "http://localhost:8085/api/products/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init(){
        
    }
    func getAppetizers(completed: @escaping (Result<[Appetizer],myError>)->Void)
    {
        
        guard let myUrl = URL(string: appetizerURL) else{
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: myUrl)){ data, response, error in
            
            if let _ = error {
                completed(.failure(.unabletoComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
              
                let decodedResponse = try JSONDecoder().decode([Appetizer].self, from: data)
                completed(.success(decodedResponse))

            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
        
    }
    
    func downloadImage(fromURLString urlString: String, completed:@escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            completed(image)
            return
        }
        guard let myUrl = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: myUrl)){ data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
            
            
        }
        task.resume()
        
    }
    
    
    
}
