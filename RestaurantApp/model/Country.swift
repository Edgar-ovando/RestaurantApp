//
//  Country.swift
//  RestaurantApp
//
//  Created by Edgar Ovando on 17/03/26.
//

import SwiftUI

// MARK: - Model
struct Country: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let code: String
    let dialCode: String
    
    var flag: String {
        code
            .unicodeScalars
            .map { 127397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}

// MARK: - Data
let countries: [Country] = [
    Country(name: "México", code: "MX", dialCode: "+52"),
    Country(name: "Estados Unidos", code: "US", dialCode: "+1"),
    Country(name: "España", code: "ES", dialCode: "+34"),
    Country(name: "Argentina", code: "AR", dialCode: "+54"),
    Country(name: "Colombia", code: "CO", dialCode: "+57"),
    Country(name: "Chile", code: "CL", dialCode: "+56"),
    Country(name: "Perú", code: "PE", dialCode: "+51")
]

// MARK: - View
struct CountryPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCountry: Country
    
    @State private var searchText = ""
    
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return countries
        }
        
        return countries.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.dialCode.contains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredCountries) { country in
                Button {
                    selectedCountry = country
                    dismiss()
                } label: {
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                        Spacer()
                        Text(country.dialCode)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Selecciona país")
            .searchable(text: $searchText)
        }
    }
}
