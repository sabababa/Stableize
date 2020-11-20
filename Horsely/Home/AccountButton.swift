//
//  AccountButton.swift
//  Horsely
//
//  Created by Saba Dawit on 9/13/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import MobileCoreServices
import CoreData

struct AccountButton: View {
    var image: String
    var body: some View {
        VStack{
            Image(image).resizable()
                .frame(width: 50.0, height: 50.0)
                .clipShape(Circle())
        }
    }
}

struct GoalButton: View {
    var body: some View {
        
            
                VStack{
                    Image("medal").resizable()
                        .frame(width: 50.0, height: 50.0)
                        .clipShape(Circle())
                }
            
    }
}

struct Profile: View {
    var body : some View{
        VStack{
            VStack{
                Text("Account Page").fontWeight(.semibold).font(.system(size: 35))
                .foregroundColor(.gray)
                HStack{
                    AccountButton(image: "bojack")
                    AccountButton(image: "bojack")
                    AccountButton(image: "bojack")
                }
            }.padding(.bottom, 20)
            List{
                NavigationLink(destination: Triggers()){
                    Text("TRIGGERS")
                        .fontWeight(.semibold)
                        .font(.system(size: 30))
                        .foregroundColor(ColorManager.darkgreen)
                }
                NavigationLink(destination: Medications()){
                    Text("MEDICATIONS")
                        .fontWeight(.semibold)
                        .font(.system(size: 30))
                    .foregroundColor(ColorManager.darkgreen)
                }
                NavigationLink(destination: ReminderView()){
                    Text("ACTION PLAN")
                    .fontWeight(.semibold)
                        .font(.system(size: 30))
                    .foregroundColor(ColorManager.darkgreen)
                }
                NavigationLink(destination: ReminderView()){
                    Text("REMINDERS")
                    .fontWeight(.semibold)
                        .font(.system(size: 30))
                    .foregroundColor(ColorManager.darkgreen)
                }
            }
        }
    }
}

struct NewMeds: View {
     var body: some View {
        VStack{
            Text("Claritin")
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .font(.title)
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.top, 5)
            .padding(.bottom, 15)
            
            HStack{
                Text("Dosage")
                Text("Oral")
                Text("Frequency")
            }
        }.frame(minWidth: 0, maxWidth: 375)
        .frame(height: 70)
        .foregroundColor(.gray)
            .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
        .cornerRadius(10)
            .padding(.top, -250)
        .padding(.bottom, 20)
    }
}
struct Medications: View {
      @Environment(\.managedObjectContext) var managedObjectContext
         // 1.
         @FetchRequest(
           // 2.
           entity: HorseMedications.entity(),
           // 3.
           sortDescriptors: [
             NSSortDescriptor(keyPath: \Reminder.title, ascending: true)
           ]
           //,predicate: NSPredicate(format: "genre contains 'Action'")
           // 4.
         ) var meds: FetchedResults<Reminder>

    var body: some View {
        VStack{
        Text("Medications").fontWeight(.semibold).font(.system(size: 35))
        .foregroundColor(.gray)
            .padding(.top, -400)
            Section(header:
                HStack{
                    Text("Medications")
                        .foregroundColor(.gray)
                        .padding(.trailing, 270)
                    Image(systemName: "plus")
                }.padding(.top, -300)){
                VStack{
                Text("Claritin")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .font(.title)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }.frame(minWidth: 0, maxWidth: 375)
                .frame(height: 70)
                .foregroundColor(.gray)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
                .cornerRadius(10)
                    .padding(.top, -250)
                .padding(.bottom, 20)
                VStack{
                Text("Inhaler")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .font(.title)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                }.frame(minWidth: 0, maxWidth: 375)
                .frame(height: 70)
                .foregroundColor(.gray)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
                .cornerRadius(10)
                .padding(.bottom, 30)
                    .padding(.top, -150)
            }
        }
    }
}
struct Triggers: View {
    var body: some View {
        VStack{
        Text("Triggers").fontWeight(.semibold).font(.system(size: 35))
        .foregroundColor(.gray)
            .padding(.top, -400)
            Section(header:
                HStack{
                    Text("Triggers")
                        .foregroundColor(.gray)
                        .padding(.trailing, 270)
                    Image(systemName: "plus")
            }.padding(.top, -300)){
                VStack{
                Text("Pollen")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .font(.title)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }.frame(minWidth: 0, maxWidth: 375)
                .frame(height: 70)
                .foregroundColor(.gray)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .padding(.top, -250)
                VStack{
                Text("Pollution")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .font(.title)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                }.frame(minWidth: 0, maxWidth: 375)
                .frame(height: 70)
                .foregroundColor(.gray)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
                .cornerRadius(10)
                .padding(.bottom, 30)
                .padding(.top, -150)
            }
        }
    }
}
