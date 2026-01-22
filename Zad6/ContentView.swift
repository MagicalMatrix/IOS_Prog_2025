//
//  ContentView.swift
//  Zad6
//
//  Created by user279431 on 01/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var paymentAlertVisible = false
    
    @State private var cardNumberField = ""
    @State private var cvvField = ""
    @State private var expirationDateField = ""
    @StateObject var paymentManager = PaymentManager()
    
    var body: some View {
        
        VStack {
            TextField("card number", text: $cardNumberField)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numericTextInput(textContent: $cardNumberField, allowedText: "0123456789")
            TextField("cvv", text: $cvvField)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numericTextInput(textContent: $cvvField, allowedText: "0123456789")
            TextField("expiration date", text: $expirationDateField)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .padding()
                .numericTextInput(textContent: $expirationDateField, allowedText: "0123456789")
            Button("Pay")
            {
                paymentManager.SimulatePaymentByServerApp(cardNumber: String(cardNumberField), cvv: cvvField, expirationDate: expirationDateField)
                paymentAlertVisible = true
            }
            .buttonStyle(.borderedProminent)
            .alert(isPresented: $paymentAlertVisible) {
                if paymentManager.paymentStatus == 0 {
                    return Alert(title: Text("Payment succeded"))
                }
                else if paymentManager.paymentStatus == 2 {
                    return Alert(title: Text("Invalid card number"))
                }
                else {
                    return Alert(title: Text("Server error"))
                }
            }
        }
        .padding()
        
        Spacer()
    }
}

//functionality for allowing only a cartain range of characters
struct NumericText: ViewModifier {
    
    @Binding var textContent: String
    let allowedText: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .onChange(of: textContent) {_, newText in
                //let allowedText = "0123456789"
                let filteredText = newText.filter {
                    allowedText.contains($0)
                }
                //text after rejecting non allowed characters is different
                if newText != filteredText {
                    textContent = filteredText
                }
                //else do nothing
            }
    }
}

extension View {
    func numericTextInput(textContent: Binding<String>, allowedText: String) -> some View {
        modifier(NumericText(textContent: textContent, allowedText: allowedText))
    }
}

#Preview {
    ContentView()
}
