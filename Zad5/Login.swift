//
//  Login.swift
//  Zad5
//
//  Created by user279431 on 12/28/25.
//
import SwiftUI

struct UserJson: Decodable {
    let username: String
}

class LoginManager: ObservableObject {
    @Published var result = ""
    @Published var loggedUser = "not logged in"
    @Published var loggingStatus = 0
    
    func LoginByServerApp(username: String, password: String) {
        //print(username)
        //print(password)
        print("troed to log in")
        
        let url = URL(string: "http://127.0.0.1:5000/login")!
        
        let sendData: [String: Any] =
        [
            "username": username,
            "password": password
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
                self.loggingStatus = 3
                return
            }
            guard let result = response as? HTTPURLResponse else {
                print("invalid response")
                self.loggingStatus = 3
                return
            }
            
            //incorrect logging
            if (401...).contains(result.statusCode) {
                print("incorrect password")
                self.loggingStatus = 2
                return
            }
            
            if (400...).contains(result.statusCode) {
                print("username not found")
                self.loggingStatus = 1
                return
            }

            //user found retrive data
            let decoder = JSONDecoder()
            do {
                let dataContent = try decoder.decode(UserJson.self, from: data)
                print(dataContent)
                print("logged in")
                self.loggedUser = dataContent.username
                self.loggingStatus = 0
                return
            } catch {
                print("error retriving data")
            }

        }
        task.resume()
    }
}
