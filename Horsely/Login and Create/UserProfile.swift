//
//  UserProfile.swift
//  Horsely
//
//  Created by Saba Dawit on 11/18/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import Firebase

struct UserProfile: View {
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    
    @EnvironmentObject var session: SessionStore
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var username: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    func getUser () {
        session.listen()
    }
    
    func signIn () {
        loading = true
        error = false
        session.signIn(email: username, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.username = ""
                self.password = ""
                
                
            }
        }
    }
    func signUp () {
        loading = true
        error = false
        session.signUp(email: username, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.username = ""
                self.password = ""
                self.viewRouter.currentPage = "page5"
                
            }
        }
    }
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Login Information")) {
                    TextField("Username", text: $username)
                    TextField("Password", text: $password)
                }
            }
            Button(action: {
                self.signUp()
            }){
                CreateButtonContent()
            }
        }.onAppear(perform: getUser)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
