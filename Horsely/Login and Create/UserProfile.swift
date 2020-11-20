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
        self.ref.child("users").child(self.user!.uid).setValue(["email": user?.email])
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
                self.signIn()
                self.viewRouter.currentPage = "page3"
            }){
                CreateButtonContent()
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
