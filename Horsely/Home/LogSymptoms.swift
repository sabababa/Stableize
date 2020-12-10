//
//  LogSymptoms.swift
//  Horsely
//
//  Created by Saba Dawit on 9/30/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import MobileCoreServices
import FirebaseDatabase
import Firebase

struct LogSymptoms: View {
    static let DefaultReminderTitle = "An untitled masterpiece"
    @State var mood: String = ""
    @State var triggers: String = ""
    @State var name: String = ""
    @State var dustExposure: Bool = true
    @State var pollen: Bool = true
    @State var humidity: Bool = true
    @State var temperature: Bool = true
    @State var symptoms: String = ""
    @State var doctor: Bool = true
    @State var medsTaken: Bool = true
    @State var freqCough: Double = 0
     @State var performance: Double = 0
    @State var mucus: Double = 0
    @State var abnormal: Double = 0
    @State var date = Date()
    static let releaseFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .long
      return formatter
    }()
    
    @State var notificationsEnabled: Bool = false
    let user = Auth.auth().currentUser
     var ref = Database.database().reference()
    var count = 0
    var moods = ["Amazing", "Good", "Ok", "Not So Great", "Terrible"]
     @State private var selectedMood = 0
    let onComplete: (String, String, String, String, Bool, Date) -> Void
    
       var body: some View {
           NavigationView {
               Form {
                   Section(header: Text("MOOD")) {
                    VStack{
                     Picker(selection: $selectedMood, label: Text("How Does Bojack Feel Today")) {
                                          ForEach(0 ..< moods.count) {
                                             Text(self.moods[$0])
                                          }
                                       }
                        
                    }
                }
                Section(header: Text("Symptoms")){
                    VStack {
                        Text("Frequency of Coughing")
                        Slider(value: $freqCough, in: 1...4, step: 1)
                    }
                    VStack {
                        Text("Mucous nasal discharge after exercise")
                        Slider(value: $mucus, in: 1...2, step: 1)
                    }
                    VStack {
                        Text("Abnormal breathing at rest, during, or after exercise")
                        Slider(value: $abnormal, in: 1...2, step: 1)
                    }
                    VStack {
                        Text("Subjective Performance")
                        Slider(value: $performance, in: 1...4, step: 1)
                    }
                    
                    
                       Toggle(isOn: $medsTaken) {
                           Text("Did you take your meds today?")
                       }
                    
                    Toggle(isOn: $doctor) {
                        Text("Did you visit the doctor today?")
                    }
                }
                   Section(header: Text("Additional Symptoms")) {
                TextField("Other Symptoms", text: $symptoms)
                }
                   Section(header: Text("TRIGGERS")) {
                   Toggle(isOn: $dustExposure) {
                       Text("Dust Exposure")
                   }
                   Toggle(isOn: $pollen) {
                       Text("Pollen")
                   }
                   Toggle(isOn: $humidity) {
                       Text("Humidity")
                   }
                   Toggle(isOn: $temperature) {
                       Text("Temperature")
                   }
                   }
                
                   Section {
                       Button(action: {
                        self.addMoveAction()
                        let uid = self.user?.uid
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("triggers").child("dust").setValue(self.dustExposure)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("triggers").child("pollen").setValue(self.pollen)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("triggers").child("humidity").setValue(self.humidity)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("triggers").child("temperature").setValue(self.temperature)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("symptoms").child("frequency of coughing").setValue(self.freqCough)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("symptoms").child("mucus").setValue(self.mucus)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("symptoms").child("abnormal breathing").setValue(self.abnormal)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("symptoms").child("performance").setValue(self.performance)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("symptoms").child("other").setValue(self.symptoms)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("mood").setValue(self.mood)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("medsTaken").setValue(self.medsTaken)
                        self.ref.child("users").child(uid!).child("logs").child(LogSymptoms.releaseFormatter.string(from: self.date)).child("doctor's visit").setValue(self.doctor)

                       }) {
                           Text("Finish Log")
                       }
                   }
               }
               .navigationBarTitle("Daily Log")
             
           }
       }
    
    private func addMoveAction() {
        mood = moods[selectedMood]
      onComplete(mood, triggers, symptoms, name, medsTaken, date)
    }
}

