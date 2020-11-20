//
//  Mood.swift
//  Horsely
//
//  Created by Saba Dawit on 9/11/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct Mood: View {
    
    var image: String
    var title: String
    var type: String
    var price: String
    
    var body: some View {
        HStack(alignment: .center) {
             Image(image).resizable()
                               .frame(width: 60.0, height: 60.0)
                               .clipShape(Circle())
                               .overlay(
                           Circle().stroke(ColorManager.darkgreen, lineWidth: 2))
                               .shadow(radius: 10)
                               .font(.title)
                               .padding(.leading, 20)
                .padding(.top, -25)
            
            VStack(alignment: .leading) {
                Text(type)
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(.gray)
                    .padding(.top, 15)
                Text(title)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(ColorManager.darkgreen)
                HStack {
                    VStack{
                    Text(price)
                        .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(ColorManager.darkgreen)
                        .padding(.top, 40)
                        .padding(.leading, -75)
                        Text("-")
                            .padding(.leading, -40)
                    }
                    VStack{
                    Text("Triggers")
                        .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(ColorManager.darkgreen)
                        .padding(.top, 40)
                        .padding(.leading, 45)
                    Text("-")
                    .padding(.leading, 43)
                    }
                    VStack{
                    Text("PeakFlow")
                        .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(ColorManager.darkgreen)
                        .padding(.top, 40)
                        .padding(.leading, 55)
                    Text("-")
                    .padding(.leading, 43)
                    }
                }
            }.padding(.trailing, 20)
                .padding(.bottom, 30)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(ColorManager.bluewhite)
        .padding(.all, 10)
        .shadow(radius: 10)
    }
}

struct NewMood : View {
    @State var isPresented = false
     let daily: Daily
    var ref = Database.database().reference()
     static let releaseFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .long
       return formatter
     }()

     var body: some View {

       HStack(alignment: .center) {
        Image("smile").resizable()
                                  .frame(width: 60.0, height: 60.0)
                                  .clipShape(Circle())
                                  .overlay(
                              Circle().stroke(ColorManager.darkgreen, lineWidth: 2))
                                  .shadow(radius: 10)
                                  .font(.title)
                                  .padding(.leading, 20)
                   .padding(.top, -25)
               
               VStack(alignment: .leading) {
                Button(action: {
                    self.isPresented.toggle()
                }) {
                   daily.date.map { Text(Self.releaseFormatter.string(from: $0)) }
                   .font(.system(size: 12, weight: .bold, design: .default))
                   .foregroundColor(.gray)
                       .padding(.top, 15)
                    }.sheet(isPresented: $isPresented) {
                        FullView(showSheetView: self.$isPresented, ref: self.ref, mood: "", mucus: 0, freqCough: 0, abnormalBreathing: 0, performance: 0, dust: false, humidity: false, pollen: false, temperature: false)
                        }
                   daily.mood.map(Text.init)
                       .font(.system(size: 26, weight: .bold, design: .default))
                       .foregroundColor(ColorManager.darkgreen)
                   HStack {
                       VStack{
                       Text("Weather")
                           .font(.system(size: 12, weight: .bold, design: .default))
                       .foregroundColor(ColorManager.darkgreen)
                           .padding(.top, 40)
                           .padding(.leading, -75)
                           Text("65")
                            .padding(.leading, -60)
                       }
                       VStack{
                       Text("Triggers")
                           .font(.system(size: 12, weight: .bold, design: .default))
                       .foregroundColor(ColorManager.darkgreen)
                           .padding(.top, 40)
                           .padding(.leading, 45)
                       Text("2")
                       .padding(.leading, 50)
                       }
                       VStack{
                       Text("Doctor Visit?")
                           .font(.system(size: 12, weight: .bold, design: .default))
                       .foregroundColor(ColorManager.darkgreen)
                           .padding(.top, 40)
                           .padding(.leading, 55)
                        if(daily.medsTaken == true){
                       Text("Yes")
                       .padding(.leading, 43)
                        }
                        else{
                            Text("No")
                            .padding(.leading, 43)
                        }
                       }
                   }
               }.padding(.trailing, 20)
                   .padding(.bottom, 10)
               Spacer()
           }
           .frame(maxWidth: .infinity, alignment: .center)
           .background(ColorManager.bluewhite)
           .padding(.all, 10)
           .shadow(radius: 10)
       }
}

struct Today: View{
    
    @Environment(\.managedObjectContext) var managedObjectContext
             // 1.
             @FetchRequest(
               // 2.
               entity: Daily.entity(),
               // 3.
               sortDescriptors: [
                   NSSortDescriptor(keyPath: \Daily.date, ascending: true)
                ], predicate: NSPredicate(format: "date >= %@", Calendar.current.startOfDay(for: Date()) as NSDate)
               // 4.
       )
       var reminders: FetchedResults<Daily>
    @ViewBuilder
    var body: some View {
        if reminders.count == 0{
             Mood(image: "smile", title: "Log Today", type: "Not Sure", price: "Symptoms")
        }
        ForEach(reminders, id: \.date) {
                   NewMood(daily: $0)
                   }
    }
    
}

struct Rating : View{
    @Binding var rating: Int
    
    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    var body: some View{
        VStack{
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
        
        
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}
struct Mood_Previews: PreviewProvider {
    static var previews: some View {
        Today()
    }
}
