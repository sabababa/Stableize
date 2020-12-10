//
//  Login.swift
//  Horsely
//
//  Created by Saba Dawit on 10/27/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseDatabase
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

import SwiftUI


struct Login: View {
     @State var username: String = ""
       @State var password: String = ""
       @State var authenticationDidFail: Bool = false
       @State var authenticationDidSucceed: Bool = false
       @EnvironmentObject var viewRouter: ViewRouter
       @EnvironmentObject var session: SessionStore
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
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
                    self.viewRouter.currentPage = "page2"
                
                   self.authenticationDidSucceed = true
               }
           }
       }
       
       var body: some View {
           ZStack{
               VStack {
                   WelcomeText()
                   UserImage()
                   UsernameTextField(username: $username)
                   PasswordSecureField(password: $password)
                   if authenticationDidFail {
                       Text("Information not correct. Try again.")
                           .offset(y: -10)
                           .foregroundColor(.red)
                   }
                   
                   Button(action:signIn) {
                       
                           
                           LoginButtonContent()
                           
                       
                   }
                   .padding(.bottom, 20)
                   Button(action: {
                       print("Pressed")
                       self.viewRouter.currentPage = "page4"}) {
                       CreateButtonContent()
                   }
               }               .padding()
               
               if authenticationDidSucceed {
                   Text("Login succeeded!")
                   .font(.headline)
                   .frame(width: 250, height: 80)
                   .background(Color.green)
                   .cornerRadius(20.0)
                   .foregroundColor(.white)
                   .animation(Animation.default)
               }
           }.onAppear(perform: getUser)
        
       }
}
struct CreateLogin: View {
     @State var username: String = ""
       @State var password: String = ""
       @State var authenticationDidFail: Bool = false
       @State var authenticationDidSucceed: Bool = false
       @EnvironmentObject var viewRouter: ViewRouter
       @EnvironmentObject var session: SessionStore
    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
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
                
                   self.viewRouter.currentPage = "page3"
                
                   self.authenticationDidSucceed = true
               }
           }
       }
       
       var body: some View {
           ZStack{
               VStack {
                   WelcomeText()
                   UserImage()
                   UsernameTextField(username: $username)
                   PasswordSecureField(password: $password)
                   if authenticationDidFail {
                       Text("Information not correct. Try again.")
                           .offset(y: -10)
                           .foregroundColor(.red)
                   }
                   
                   Button(action:signIn) {
                       
                           
                           LoginButtonContent()
                           
                       
                   }
                   .padding(.bottom, 20)
                   Button(action: {
                       print("Pressed")
                       self.viewRouter.currentPage = "page4"}) {
                       CreateButtonContent()
                   }
               }               .padding()
               
               if authenticationDidSucceed {
                   Text("Login succeeded!")
                   .font(.headline)
                   .frame(width: 250, height: 80)
                   .background(Color.green)
                   .cornerRadius(20.0)
                   .foregroundColor(.white)
                   .animation(Animation.default)
               }
           }.onAppear(perform: getUser)
        
       }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(exists: false).environmentObject(ViewRouter())
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome Back!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("mini-horse")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.blue)
            .cornerRadius(15.0)
    }
}

struct CreateButtonContent: View {
    var body: some View {
        Text("CREATE")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 40)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameTextField: View {
    @Binding var username: String
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct MotherView : View {
    @EnvironmentObject var viewRouter: ViewRouter
    let user = Auth.auth().currentUser
    var ref = Database.database().reference()
    
    @State var exists: Bool
    var body: some View {
        VStack {
            if viewRouter.currentPage == "page1" {
                Login().environmentObject(SessionStore())
            } else if viewRouter.currentPage == "page4" {
                UserProfile().environmentObject(SessionStore())
            } else if viewRouter.currentPage == "page3" {
                CreateAccount().environmentObject(SessionStore())
            } else if viewRouter.currentPage == "page2" {
                Home(exists: exists)
            }
            else if viewRouter.currentPage == "page5" {
                CreateLogin().environmentObject(SessionStore())
            }
        }.onAppear(perform: getData)
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("logs").child(LogSymptoms.releaseFormatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
                if(snapshot.exists()){
                   self.exists = true
                   print(self.exists)
                }
            }) { (error) in
             print(error.localizedDescription)
        }
        
    }
}
