//
//  Home.swift
//  Horsely
//
//  Created by Saba Dawit on 9/10/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import Combine
import FirebaseDatabase
import FirebaseAuth

struct FullView: View {
    @Binding var showSheetView: Bool
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    @State var mood : String
    @State var mucus : Int
    @State var freqCough : Int
    @State var abnormalBreathing : Int
    @State var performance : Int
    @State var dust : Bool
    @State var humidity : Bool
    @State var pollen : Bool
    @State var temperature : Bool
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Logs").fontWeight(.semibold).font(.system(size: 35))
                .foregroundColor(.gray)
                .padding(.top, 20)
                Text("Weather This Day").fontWeight(.semibold).font(.system(size: 27))
                .foregroundColor(.gray)
                Text("65 Degrees Farenheit").fontWeight(.semibold).font(.system(size: 18))
                .foregroundColor(.gray)
                
                Section(header: HStack{
                               Text("Medical Assistance")
                                   .foregroundColor(.gray)
                                   .padding(.trailing, 200)
                               Image(systemName: "plus")
                       }){
                        Boxes(text: "Doctor's Visit")
                }
                
                Section(header:
                      HStack{
                              Text("Symptoms")
                                  .foregroundColor(.gray)
                                  .padding(.trailing, 260)
                              Image(systemName: "plus")
                      }){
                          if freqCough > 0 {
                              Boxes(text: "Frequency of Coughing")
                          }
                          if abnormalBreathing > 0 {
                          Boxes(text: "Abnormal Breathing")
                          }
                          
                          if mucus > 0 {
                          Boxes(text: "Mucus Nasal Discharge")
                          }
                          
                          if performance > 0 {
                          Boxes(text: "Subjective Performance")
                          }
                }
                
                Section(header:
                           HStack{
                               Text("Triggers")
                                   .foregroundColor(.gray)
                                   .padding(.trailing, 270)
                               Image(systemName: "plus")
                       }){
                            if dust == true {
                                Boxes(text: "Dust")
                            }
                            if humidity == true {
                                Boxes(text: "Humidity")
                            }
                                      
                            if pollen == true {
                                Boxes(text: "Pollen")
                            }
                                      
                            if temperature == true {
                                Boxes(text: "Temperature")
                        }
                }
                
                Section(header: HStack{
                               Text("Medications")
                                   .foregroundColor(.gray)
                                   .padding(.trailing, 260)
                               Image(systemName: "plus")
                       }){
                        Boxes(text: "Clenbuterol Taken")
                        
                }
                
            }
        }.onAppear(perform: getData)
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("logs").child(LogSymptoms.releaseFormatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
           
                let value = snapshot.value as? NSDictionary
                let symptoms = value?["symptoms"] as? NSDictionary
                let triggers = value?["triggers"] as? NSDictionary
                self.abnormalBreathing = (symptoms?["abnormal breathing"] as? Int)!
                self.freqCough = (symptoms?["frequency of coughing"] as? Int)!
                self.mucus = (symptoms?["mucus"] as? Int)!
                self.performance = (symptoms?["performance"] as? Int)!
                self.dust = (triggers?["dust"] as? Bool)!
                self.humidity = (triggers?["humidity"] as? Bool)!
                self.pollen = (triggers?["pollen"] as? Bool)!
                self.temperature = (triggers?["temperature"] as? Bool)!
                let moodData = value?["mood"] as? String ?? ""
                self.mood = moodData
            }) { (error) in
             print(error.localizedDescription)
        }
        
    }
}

struct Boxes: View {
    @State var text : String
    var body: some View {
        VStack{
        Text(text)
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
    }
}
struct PhotoCaptureView: View {
    
    @Binding var showImagePicker    : Bool
    @Binding var image              : Image?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
}
struct ActionPlan: View{
    var body: some View{
        VStack{
            Image("action")
            .resizable()
            .frame(width: 400.0, height: 400.0)
        }.navigationBarTitle("Action Plan")
    }
}
struct Emergency: View{
    @Binding var showHorseView: Bool
    @State private var showImagePicker : Bool = false
    @State private var image : Image? = nil
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
     @State private var numberString = "678-360-5712"
    @State private var name = "Call "
    var body: some View {
        NavigationView{
            
            VStack {
                Text("EMERGENCY")
                .fontWeight(.semibold)
                .font(.system(size: 35))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, -100)
                
                Text(self.name)

                Button(action: {
                    let telephone = "tel://"
                    let formattedString = telephone + self.numberString
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                   }) {
                   Text(numberString)
                    .padding(.bottom, 30)
                }
                image?.resizable().scaledToFit()
                
                Button("Upload Plan"){
                    self.showImagePicker = true
                }.padding()
                .foregroundColor(Color.white)
                .background(Color.purple)
                .cornerRadius(10)
            }.sheet(isPresented: self.$showImagePicker){
                PhotoCaptureView(showImagePicker: self.$showImagePicker, image: self.$image)

            }
        }.onAppear(perform: getData)
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("Vet").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let number = value?["number"] as? String
                let name = value?["name"] as? String
                self.numberString = number!
                self.name = self.name + name!
            }) { (error) in
             print(error.localizedDescription)
        }
        
    }
    
}

struct MedicationDetail: View{
    let meds: HorseMedications
    var body: some View{
        VStack{
            meds.name.map(Text.init)!
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
            meds.administration.map(Text.init)!
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
            meds.dosageType.map(Text.init)!
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
        }
    }
}
struct EditMedView: View {
    @Environment(\.managedObjectContext) var moc
    // 1.
    @FetchRequest(
      // 2.
      entity: HorseMedications.entity(),
      // 3.
      sortDescriptors: [
        NSSortDescriptor(keyPath: \HorseMedications.name, ascending: true)
      ]
      //,predicate: NSPredicate(format: "genre contains 'Action'")
      // 4.
    ) var meds: FetchedResults<HorseMedications>
    
    var body: some View {
        VStack{
            List{
                ForEach(meds, id: \.name) {
                  StoredMeds(meds: $0)
                        
                }
                .onDelete(perform: deleteMed)
            }
        }.navigationBarTitle("Medications")
    }
    func deleteMed(at offsets: IndexSet) {
      // 1.
      offsets.forEach { index in
        // 2.
        let med = self.meds[index]

        // 3.
        self.moc.delete(med)
      }

      // 4.
      saveContext()
    }
    func saveContext() {
      do {
        try moc.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}


struct SettingsView: View {
    @Environment(\.managedObjectContext) var moc
    // 1.
    @FetchRequest(
      // 2.
      entity: HorseMedications.entity(),
      // 3.
      sortDescriptors: [
        NSSortDescriptor(keyPath: \HorseMedications.name, ascending: true)
      ]
      //,predicate: NSPredicate(format: "genre contains 'Action'")
      // 4.
    ) var meds: FetchedResults<HorseMedications>
    @State var notif: Bool
    @State private var showingAlert = false
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View{
            
        ScrollView{
            Text("Settings").fontWeight(.semibold).font(.system(size: 35))
            .foregroundColor(.gray)
                .padding(.top, -60)
            Section(header:
            HStack{
                NavigationLink(destination: EditMedView()){
                    Text("Edit Medications")
                        .foregroundColor(.gray)
                        .padding(.trailing, 240)
                }
                    Image(systemName: "plus")
            }){
                ForEach(meds, id: \.name) {
                    
                  StoredMeds(meds: $0)
                }
            }
            
            Section(header:
                HStack{
                    Text("Triggers")
                        .foregroundColor(.gray)
                        .padding(.trailing, 270)
                    Image(systemName: "plus")
            }){
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
            }
            
            Section(header: HStack{
                    Text("Edit Notifications")
                        .foregroundColor(.gray)
                        .padding(.trailing, 260)
            }){
                Toggle(isOn: $notif) {
                    Text("Allow Notifications")
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                }
                Toggle(isOn: $notif) {
                    Text("Badges")
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                }
            }
            
            HStack{
            NavigationLink(destination: ActionPlan()){
                       Text("View Action Plan")
                       .font(.headline)
                       .foregroundColor(.white)
                       .padding()
                       .frame(width:170, height: 40)
                       .background(Color.green)
                       .cornerRadius(15.0)
                       }
            .padding(.bottom, 20)
                .padding(10)
                NavigationLink(destination: ActionPlan()){
                           Text("Send Report")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: 170, height: 40)
                           .background(Color.green)
                           .cornerRadius(15.0)
                           }
                .padding(.bottom, 20)
            .padding(10)
            }
            
            Button(action: {
                self.showingAlert = true
            }) {
                Text("Switch to Hollyhock's Profile")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Switch Profiles"), message: Text("You're currently viewing Hollyhock's information!"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
    
}
struct StoredMeds: View{
    let meds: HorseMedications
    @State private var editMode = EditMode.inactive
    @State var isPresented = false
    var ref = Database.database().reference()
    @State private var showPopUp = false
    var body: some View{
        ZStack{
        VStack{
            Button(action: {
                self.isPresented.toggle()
            }) {
            meds.name.map(Text.init)!
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .font(.title)
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.top, 15)
            .padding(.bottom, 15)
            }.sheet(isPresented: $isPresented) {
                FullView(showSheetView: self.$isPresented, ref: self.ref, mood: "", mucus: 0, freqCough: 0, abnormalBreathing: 0, performance: 0, dust: false, humidity: false, pollen: false, temperature: false)
            }
            HStack{
                Text("2")
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
            meds.administration.map(Text.init)!
            .fontWeight(.semibold)
            .font(.system(size: 12))
            .font(.title)
            .padding(.trailing, 20)
            .padding(.leading, 20)
            .padding(.top, 15)
            .padding(.bottom, 15)
                meds.dosageType.map(Text.init)!
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
               
            }
        }.frame(minWidth: 0, maxWidth: 375)
        .frame(height: 80)
        .foregroundColor(.gray)
            .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing).opacity(0.5))
        .cornerRadius(10)
        .padding(.bottom, 20)
        }
    }
}
struct Home: View {
    @Environment(\.managedObjectContext) var managedObjectContext
          // 1.
          @FetchRequest(
            // 2.
            
            entity: Daily.entity(),
            // 3.
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Daily.date, ascending: true)
            ],
            predicate: NSPredicate(format: "date >= %@", Calendar.current.startOfDay(for: Date()) as NSDate)
            // 4.
    )
    var reminders: FetchedResults<Daily>
    
    
    @Environment(\.managedObjectContext) var moc
       // 1.
       @FetchRequest(
         // 2.
         entity: Horses.entity(),
         // 3.
         sortDescriptors: [
           NSSortDescriptor(keyPath: \Horses.name, ascending: true)
         ]
         //,predicate: NSPredicate(format: "genre contains 'Action'")
         // 4.
       ) var horse: FetchedResults<Horses>
    
    @State var isPresented = false
    @State var showSheetView = false
    @State var showHorseView = false
    @State var exists : Bool
    @State var mood = ""
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    @State var text = "Log Secretariat's Symptoms"
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                   
                        AccountButton(image: "gear").padding(.trailing, 10)
                        NavigationLink(destination: Goals()){
                            VStack{
                        
                             Text("Welcome Back,").fontWeight(.semibold).font(.system(size: 15))
                                                              .foregroundColor(.gray)
                                                              .padding(.leading, -5)
                                
                            }.padding(.trailing, 70)
                                
                        }
                        HStack{
                            VStack{
                                Text("400")
                                Text("points")
                            }
                                .font(.system(size: 15))
                            GoalButton()
                        }
                        .padding(.leading, 25)
                    }.padding(.top, -40)
                    .padding(.bottom, 40)
                    
                    Name(ref: ref, mood: "" )
                    .padding(.top, -60)
                        .padding(.leading, -80)
                    
                    HStack{
                        NavigationLink(destination: SettingsView(notif: true)){
                            VStack{
                                Text("...")
                                    .font(.system(size: 100))
                                    .opacity(0)
                            }.padding(.trailing, 120)
                                
                        }
                        NavigationLink(destination: Goals()){
                            VStack{
                                Text("...")
                                    .font(.system(size: 100))
                                    .opacity(0)
                            }.padding(.leading, 120)
                        }
                    }.padding(.top, -120)
                Button(action: {
                    self.getData()
                                       self.isPresented.toggle()
                                   }) {
                                    VStack{
                                    Text(text)
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
                    }.sheet(isPresented: $isPresented) {
                        
                        if(self.exists == false){
                        LogSymptoms{ mood, triggers, symptoms, whichMeds, medsTaken, date in
                            self.addLog(mood: mood, triggers: triggers, symptoms: symptoms, whichMeds: whichMeds, medsTaken: medsTaken, date: date)
                        self.isPresented = false
                            self.exists = true
                            self.getData()
                            print(self.exists)
                        }
                        }
                        else{
                            FullView(showSheetView: self.$isPresented, ref: self.ref, mood: "", mucus: 0, freqCough: 0, abnormalBreathing: 0, performance: 0, dust: false, humidity: false, pollen: false, temperature: false)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 10)
                .padding(.leading, 10)
                Spacer()
                    WhichRating(mood: "", exists: self.exists)
                HStack{
                    NavigationLink(destination: Reading()){
                VStack{
                Text("Asthma Education")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .font(.title)
                    Image(systemName: "bookmark")
                }.frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 125)
                .padding()
                .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.darkgreen]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(8)
                    }
                    NavigationLink(destination: ReminderView()){
                     
                    VStack{
                    Text("Reminders")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .font(.title)
                        Image(systemName: "clock")
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 125)
                    .padding()
                    .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.darkgreen]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    }
                }.padding(.bottom, 25)
                    .padding(.leading, 20)
                .padding(.trailing, 20)
                
                
                    HStack{
                        NavigationLink(destination: Trends()){
                    VStack{
                    Text("Trends")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .font(.title)
                        Image(systemName: "person")
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 125)
                    .padding()
                    .foregroundColor(.white)
                     .background(LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.darkgreen]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                        }
                        NavigationLink(destination: ExpadedLog()){
                        VStack{
                        Text("Weather")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                            .font(.title)
                            Image(systemName: "sunrise")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 125)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.darkgreen]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                    
                        }
                }.padding(.bottom, 25)
                    .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Button(action: {
                    self.showHorseView.toggle()
                })  {
                VStack{
                Text("EMERGENCY")
                    .fontWeight(.semibold)
                    .font(.system(size: 35))
                    .font(.title)
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                }.frame(minWidth: 0, maxWidth: 375)
                .frame(height: 100)
                .foregroundColor(.gray)
                    .background(LinearGradient(gradient: Gradient(colors: [ColorManager.mintgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                    .padding(.top, 20)
                    }.sheet(isPresented: $showHorseView) {
                                  Emergency(showHorseView: self.$showHorseView)
                                  }
                
                }
                
               
            }.onAppear(perform: getData)
            
            
        }
           
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("logs").child(LogSymptoms.releaseFormatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                let moodData = value?["mood"] as? String ?? ""
            self.mood = moodData
               if(snapshot.exists()){
                   self.exists = true
                   print(self.exists)
               }
            }) { (error) in
             print(error.localizedDescription)
        }
        
    }
    
    func addLog(mood: String, triggers: String, symptoms: String, whichMeds: String, medsTaken: Bool, date: Date) {
      // 1
      let newEntry = Daily(context: managedObjectContext)

      // 2
      newEntry.mood = mood
        newEntry.triggers = triggers
        newEntry.symptoms = symptoms
        newEntry.whichMeds = whichMeds
        newEntry.medsTaken = medsTaken
      newEntry.date = date
        

      // 3
      saveContext()
    }//closes function
    
    func saveContext() {
       do {
         try managedObjectContext.save()
       } catch {
         print("Error saving managed object context: \(error)")
       }
     }//closes func
    
}//closes struct

struct WhichRating: View {
    @State var mood : String
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    @State var exists : Bool
    var body : some View {
        VStack{
            if(self.exists == false){
                Rating(rating: .constant(0)).padding(.top, 20)
                Spacer()
                Text("How Does Secretariat Feel Today?").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
             Spacer()
            }
            else{
                if(self.mood == ""){
                    Rating(rating: .constant(0)).padding(.top, 20)
                    Text("How Does Secretariat Feel Today?").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
                if(self.mood == "Amazing"){
                    Rating(rating: .constant(5)).padding(.top, 20)
                    Text("Bojack Feels Stablelized Today!!").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
                if(self.mood == "Good"){
                    Rating(rating: .constant(4)).padding(.top, 20)
                    Text("Bojack Feels Good Today!!").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
                if(self.mood == "Ok"){
                    Rating(rating: .constant(3)).padding(.top, 20)
                    Text("Bojack Feels OK Today!").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
                if(self.mood == "Not So Great"){
                    Rating(rating: .constant(2)).padding(.top, 20)
                    Text("Bojack Isn't Feeling Great Today.").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
                if(self.mood == "Terrible"){
                    Rating(rating: .constant(1)).padding(.top, 20)
                    Text("Bojack Feels Terrible Today.").font(.system(size: 20)).foregroundColor(.gray).padding(.bottom, 40)
                    Spacer()
                }
            }
        }.onAppear(perform: getData)
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("logs").child(LogSymptoms.releaseFormatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
            if(snapshot.exists()){
                self.exists = true
                print(self.exists)
            }
               let value = snapshot.value as? NSDictionary
            self.mood = value?["mood"] as? String ?? ""
            }) { (error) in
             print(error.localizedDescription)
        }
        
    }
}
struct Name: View{
    var ref = Database.database().reference()
    let user = Auth.auth().currentUser
    @State var mood : String
    var body: some View {
        VStack{
        Text("Secretariat")
            .fontWeight(.semibold).font(.system(size: 20))
        .padding(.leading, 10)
        .foregroundColor(.gray)
        }.onAppear(perform: getData)
    }
    
    func getData(){
        
        ref.child("users").child(user!.uid).child("logs").child(LogSymptoms.releaseFormatter.string(from: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let moodData = value?["mood"] as? String ?? ""
            
            self.mood = moodData
            }) { (error) in
             print(error.localizedDescription)
        }
        
        ref.child("users").child(user!.uid).child("logs").observe(.value, with: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in snapshots {
                       print(child)
                       // print("Child: ", medication)
                    }
                }

            })
        
    }
}
