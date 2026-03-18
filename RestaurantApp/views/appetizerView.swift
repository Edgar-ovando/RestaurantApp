//
//  ContentView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 19/11/25.
//

import SwiftUI

struct appetizerView: View {
    
    @State private var appetizers: [Appetizer] = []
    @State var alertItem: AlertItem?
    @State var isLoading = false
    @State private var isShowingDetail = false
    @State private var selectedAppetizer: Appetizer?
    
    var body: some View {
        ZStack{
            NavigationStack{
                List(appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture {
                            selectedAppetizer = appetizer
                            isShowingDetail = true
                        }
                }
                .navigationTitle("🍟 Appetizers")
                .disabled(isShowingDetail)
                
            }.onAppear{
                getAppetizersAPI()
            }
            .blur(radius: isShowingDetail ? 20: 0)
            
            if isShowingDetail {
                
                AppetizerDetailView(appetizer: selectedAppetizer!,
                                    isShowingDetail: $isShowingDetail)
            }
            
            if isLoading
            {
                LoadingView()
            }
        }
        .alert(item: $alertItem){ alertItem in
            
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }

    }
    
    func getAppetizersAPI(){
        
        isLoading = true
        
        AppetizerService.shared.getAppetizers { [self] result in
            
            DispatchQueue.main.async {
                
                isLoading = false
                
                switch result{
                    
                case .success(let appetizers):
                    self.appetizers = appetizers
                    
                case .failure(let error):
                    switch error{
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

#Preview {
    appetizerView()
}
