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
                    Button(action: {
                        self.showSheetView.toggle()
                    }) {
                        CardView(image: "horse3", category: "Medication", heading: "What is Equine Asthma", author: "Simon Ng")}.sheet(isPresented: self.$showSheetView) {
                        ArticleView(showSheetView: self.$showSheetView, number: 0)
                    }.buttonStyle(PlainButtonStyle())
                    .background(ColorManager.darkgreen.opacity(0.5))
                }
                   
                .padding(.top, -40)
                    
                Button(action: {
                                       self.showSheetView.toggle()
                                   }) {
                CardView(image: "horse2", category: "Action", heading: "What does Equine Asthma look like in a horse?", author: "Simon Ng")}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 1)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                    
                    Button(action: {
                        self.showSheetView.toggle()
                    }) {
                CardView(image: "horse3", category: "Emergency", heading: "How is Equine Asthma treated?", author: "Simon Ng")}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 2)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                CardView(image: "horse2", category: "Info", heading: "Are there other terms for Equine Asthma? ", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 3)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                CardView(image: "horse3", category: "Info", heading: "Severe?", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 4)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                CardView(image: "horse2", category: "Info", heading: "Is there a cure for Equine Asthma?", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 5)
                }.buttonStyle(PlainButtonStyle())
                .background(ColorManager.darkgreen.opacity(0.5))
                
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                CardView(image: "horse3", category: "Info", heading: "Asthma Management", author: "Simon Ng")
                .background(ColorManager.darkgreen.opacity(0.5))}.sheet(isPresented: self.$showSheetView) {
                    ArticleView(showSheetView: self.$showSheetView, number: 6)
                }.buttonStyle(PlainButtonStyle())
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
