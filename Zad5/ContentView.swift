//
//  ContentView.swift
//  Zad5
//
//  Created by user279431 on 12/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var loginStatus = 0
    @State private var loginAlertVisible = false
    
    @State private var usernameField = ""
    @State private var passwordField = ""
    @StateObject var loginManager = LoginManager()
    
    var body: some View {
        HStack{
            Spacer()
            Image(systemName: "person.circle")
            Text(loginManager.loggedUser)
                .padding()
        }
        Spacer()
        
        VStack {
            TextField("username", text: $usernameField)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .padding()
            SecureField("password", text: $passwordField)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Login")
            {
                loginManager.LoginByServerApp(username: usernameField, password: passwordField)
                loginAlertVisible = true
            }
            .buttonStyle(.borderedProminent)
            .alert(isPresented: $loginAlertVisible) {
                if loginManager.loggingStatus == 0 {
                    return Alert(title: Text("Logged succesfully"))
                }
                else if loginManager.loggingStatus == 1 {
                    return Alert(title: Text("Username not found"))
                }
                else if loginManager.loggingStatus == 2 {
                    return Alert(title: Text("Incorrect password"))
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

#Preview {
    ContentView()
}
