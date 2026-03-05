//
//  PaymentService.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 08/02/26.
//

import Foundation
import StripePaymentSheet
import Combine

class PaymentManager: ObservableObject {

    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?

    func preparePayment(amount: Int) async {

        guard let url = URL(string: "http://localhost:8080/api/payments/create-payment-intent") else {
            print("URL inválida")
            return
        }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = """
        {
            "amount": \(amount)
        }
        """.data(using: .utf8)

        do {

            let (data, _) = try await URLSession.shared.data(for: request)

            let response = try JSONDecoder().decode(PaymentResponse.self, from: data)

            var configuration = PaymentSheet.Configuration()

            configuration.merchantDisplayName = "RestaurantApp"

            configuration.allowsDelayedPaymentMethods = true

            self.paymentSheet = PaymentSheet(
                paymentIntentClientSecret: response.clientSecret,
                configuration: configuration
            )

        } catch {

            print("Error preparando pago:", error)

        }

    }

}

struct PaymentResponse: Decodable {

    let clientSecret: String

}
