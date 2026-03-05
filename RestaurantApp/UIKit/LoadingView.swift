//
//  LoadingView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 15/12/25.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable{
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(named: "brandColor")
        activityIndicator.startAnimating()
        return activityIndicator
        
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
    
  
}

struct LoadingView: View{
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            ActivityIndicator()
        }
        
    }
}
