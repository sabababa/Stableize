//
//  AddReminder.swift
//  Horsely
//
//  Created by Saba Dawit on 9/30/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import UserNotifications

struct CustomButton: View {

@State private var didTap:Bool = false
    @State var dayOfWeek: String
  var body: some View {
    Button(action: {
        print("hey")
    }) {

    Text(dayOfWeek)
        .foregroundColor(.white)
        .padding()
        .frame(width: 60, height: 35)
        .background(didTap ? Color.blue :Color.green)
        .cornerRadius(15.0)
        .font(.system(size: 12))
    }.onTapGesture(perform: {self.didTap = true})
  }
}

struct AddReminder: View {
  static let DefaultReminderTitle = "An untitled masterpiece"
  static let DefaultReminderMood = "Genre-buster"

  @State var title = ""
  @State var mood = ""
  @State var currentDate = Date()
  let onComplete: (String, String, Date) -> Void

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Reminder Title")) {
          TextField("Take Meds at 3pm", text: $title)
        }
        Section(header: Text("Notes")) {
          TextField("Notes", text: $mood)
        }
        Section {
          DatePicker(
            selection: $currentDate,
            displayedComponents: .hourAndMinute) {
              Text("Remind on Time").foregroundColor(Color(.gray))
          }
        }
        
        HStack(alignment: .center){
            CustomButton(dayOfWeek: "Mon")
            CustomButton(dayOfWeek: "Tue")
            CustomButton(dayOfWeek: "Wed")
            CustomButton(dayOfWeek: "Thu")
            CustomButton(dayOfWeek: "Fri")
        }
        .padding(.leading, 20)
        Section {
            Button(action: {
                self.addMoveAction()
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
                let content = UNMutableNotificationContent()
                content.title = "Take Meds at 10:10"
                content.subtitle = "Bojack Needs His Meds"
                content.sound = UNNotificationSound.default

                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }) {
            Text("Add Reminder")
          }
        }
      }
      .navigationBarTitle(Text("Add Reminder"), displayMode: .inline)
    }
  }

  private func addMoveAction() {
    onComplete(
      title.isEmpty ? AddReminder.DefaultReminderTitle : title,
      mood.isEmpty ? AddReminder.DefaultReminderMood : mood,
      currentDate)
  }
}
