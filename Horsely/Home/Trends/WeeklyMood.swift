//
//  WeeklyMood.swift
//  Horsely
//
//  Created by Saba Dawit on 9/24/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
struct MoodRow: View {
  let daily: Daily
  static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()

  var body: some View {
    VStack {
      daily.mood.map(Text.init)
        .font(.title)
      HStack {
        daily.triggers.map(Text.init)
          .font(.caption)
        Spacer()
       daily.date.map { Text(Self.releaseFormatter.string(from: $0)) }
          .font(.caption)
      }
    }
  }
}
struct WeeklyMood: View {
    @State var showSheetView = false
    @State var isPresented = false
    @State private var editMode = EditMode.inactive
    @Environment(\.managedObjectContext) var managedObjectContext
          // 1.
          @FetchRequest(
            // 2.
            entity: Daily.entity(),
            // 3.
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Daily.date, ascending: true)
            ]
            // 4.
    )
    var reminders: FetchedResults<Daily>
    
    var body: some View {
        VStack{
                        List{
                            ForEach(reminders, id: \.mood) {
                            NewMood(daily: $0)
                            }.onDelete(perform: deleteReminder)
                        }
            
        }
        .navigationBarTitle("This Week's Log")
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
            }
            func saveContext() {
               do {
                 try managedObjectContext.save()
               } catch {
                 print("Error saving managed object context: \(error)")
               }
             }
        }

struct WeeklyMood_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyMood()
    }
}
