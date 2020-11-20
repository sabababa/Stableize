//
//  Reading.swift
//  Horsely
//
//  Created by Saba Dawit on 9/11/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI

struct Reading: View {
    @State var showSheetView = false
    var body: some View {
        VStack{
            ScrollView(.vertical){
                VStack{
                    Text("Monday, October 7")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 210)
                    Text("Educational Reading")
                    .padding(.trailing, 115)
                    .font(.title)
                    CardView(image: "horse3", category: "Medication", heading: "Administering Medication", author: "Simon Ng") .background(ColorManager.darkgreen.opacity(0.5))
                }
                   
                .padding(.top, -40)
                Button(action: {
                                       self.showSheetView.toggle()
                                   }) {
                CardView(image: "horse2", category: "Action", heading: "Create an Action Plan", author: "Simon Ng")}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                CardView(image: "horse3", category: "Emergency", heading: "Emergency Resources", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))
                CardView(image: "horse4", category: "Info", heading: "Common Triggers", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))
            }
        }
    }
}

struct Reading_Previews: PreviewProvider {
    static var previews: some View {
        Reading()
    }
}
