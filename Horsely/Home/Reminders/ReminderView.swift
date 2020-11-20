//
//  MapView.swift
//  Horsely
//
//  Created by Saba Dawit on 9/5/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import MobileCoreServices
import UserNotifications

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 25, x: 0, y: 0)
    }
    
}

struct ReminderRow: View {
  let reminder: Reminder
  static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()

  var body: some View {
    HStack(alignment: .center) {
        
        VStack(alignment: .leading) {
            reminder.title.map(Text.init)
                .font(.system(size: 26, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(.leading, 15)
            reminder.mood.map(Text.init)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(.gray)
                .padding(.leading, 15)
            HStack {
                reminder.currentDate.map { Text(Self.releaseFormatter.string(from: $0)) }
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.leading, 15)
            }
        }.padding(.trailing, 20)
        Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .background(ColorManager.darkgreen)
    .modifier(CardModifier())
    .padding(.all, 10)
    
  }
}


struct ReminderView: View{
     @State private var editMode = EditMode.inactive
    @Environment(\.managedObjectContext) var managedObjectContext
       // 1.
       @FetchRequest(
         // 2.
         entity: Reminder.entity(),
         // 3.
         sortDescriptors: [
           NSSortDescriptor(keyPath: \Reminder.title, ascending: true)
         ]
         //,predicate: NSPredicate(format: "genre contains 'Action'")
         // 4.
       ) var reminders: FetchedResults<Reminder>

       @State var isPresented = false
   var body: some View {
        
        List {
          ForEach(reminders, id: \.title) {
            ReminderRow(reminder: $0)
          }
          .onDelete(perform: deleteReminder)
        }
        .sheet(isPresented: $isPresented) {
          AddReminder { title, mood, currentDate in
            self.addReminder(title: title, mood: mood, currentDate: currentDate)
            self.isPresented = false
          }
        }
        .navigationBarItems(trailing:
          Button(action: { self.isPresented.toggle() }) {
            Image(systemName: "plus")
          }
        )
        .navigationBarTitle("Reminders")
        
    }
    func deleteReminder(at offsets: IndexSet) {
      // 1.
      offsets.forEach { index in
        // 2.
        let reminder = self.reminders[index]

        // 3.
        self.managedObjectContext.delete(reminder)
      }

      // 4.
      saveContext()
    }

    func getOne(){
    }
    func addReminder(title: String, mood: String, currentDate: Date) {
      // 1
      let newReminder = Reminder(context: managedObjectContext)

      // 2
      newReminder.title = title
      newReminder.mood = mood
      newReminder.currentDate = currentDate

      // 3
      saveContext()
    }


    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

 

    struct ReminderView_Previews: PreviewProvider {
      static var previews: some View {
        ReminderView()
      }
    }

