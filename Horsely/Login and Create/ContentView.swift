//
//  ContentView.swift
//  Horsely
//
//  Created by Saba Dawit on 9/3/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct ContentView: View {
    @State var isActive:Bool = false
    let user = Auth.auth().currentUser
    var ref = Database.database().reference()
    
    @EnvironmentObject var viewRouter: ViewRouter
        var body: some View {
            VStack{
                if self.isActive {
                // 3.
                    MotherView(exists: false).environmentObject(ViewRouter())
                } else {
                // 4.
                    Image("image")
                        .resizable()
                        .frame(width: 400.0, height: 400.0)
                }
            
            }
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    func getData () -> Bool{
        var create: Bool = false
        ref.child("users").child(user!.uid).child("email").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                if (snapshot.exists() == false){
                    create = true
                }
            }) { (error) in
             print(error.localizedDescription)
        }
        return create
    }
    
}



