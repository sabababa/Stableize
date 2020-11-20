//
//  ContentView.swift
//  Horsely
//
//  Created by Saba Dawit on 9/3/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isActive:Bool = false
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
}



