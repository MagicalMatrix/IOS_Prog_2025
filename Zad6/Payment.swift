//
//  Login.swift
//  Zad5
//
//  Created by user279431 on 01/22/26.
//
import SwiftUI

struct UserJson: Decodable {
    let username: String
}

class PaymentManager: ObservableObject {
    @Published var result = ""
    @Published var loggedUser = "not logged in"
    @Published var paymentStatus = 0
    
    func SimulatePaymentByServerApp(cardNumber: String, cvv: String, expirationDate: String) {
        
        //payment succeded by default
        self.paymentStatus = 0
        
        let url = URL(string: "http://127.0.0.1:5000/login")!
        
        let sendData: [String: Any] =
        [
            "cardNumber": cardNumber,
            "cvv": cvv,
            "expirationDate": expirationDate
        ]
        
        let jsonPost = try? JSONSerialization.data(withJSONObject: sendData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonPost
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //definitions
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                self.paymentStatus = 3
                return
            }
            guard let result = response as? HTTPURLResponse else {
                print("invalid response")
                self.paymentStatus = 3
                return
            }
            
            //incorrect card data
            if (401...).contains(result.statusCode) {
                print("incorrect card number")
                self.paymentStatus = 2
                return
            }
            
            /*
            //user found retrive data
            let decoder = JSONDecoder()
            do {
                let dataContent = try decoder.decode(UserJson.self, from: data)
                print(dataContent)
                print("logged in")
                self.loggedUser = dataContent.username
                self.paymentStatus = 0
                return
            } catch {
                print("error retriving data")
            }
            */

        }
        task.resume()
    }
}
