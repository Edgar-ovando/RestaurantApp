//
//  PaymentView.swift
//  RestaurantApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 08/02/26.
//

import SwiftUI
import StripePaymentSheet

struct PaymentView: View {

    @StateObject private var paymentManager = PaymentManager()

    var body: some View {

        VStack(spacing: 20) {

            Button {

                Task {

                    // 1. Crear PaymentIntent en tu backend
                    await paymentManager.preparePayment(amount: 15000)

                    // 2. Mostrar Stripe PaymentSheet
                    presentPaymentSheet()

                }

            } label: {

                Text("Pagar $150 MXN")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

            }

        }
    }

    // Método profesional recomendado por Stripe
    private func presentPaymentSheet() {

        guard let paymentSheet = paymentManager.paymentSheet else {

            print("❌ PaymentSheet es nil")
            return

        }

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {

            print("❌ No se encontró rootViewController")
            return

        }

        paymentSheet.present(from: rootViewController) { result in

            paymentManager.paymentResult = result

            switch result {

            case .completed:
                print("✅ Pago exitoso")

            case .failed(let error):
                print("❌ Error:", error.localizedDescription)

            case .canceled:
                print("⚠️ Pago cancelado")

            }

        }

    }

}

#Preview {

    PaymentView()

}

