//
//  Goals.swift
//  Horsely
//
//  Created by Saba Dawit on 10/27/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI


struct AddHabit: View {
    
    @ObservedObject var habitItems : HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var dateTarget = Date()
    @State private var type = "To Build"
    @State private var note = ""
    
    @State private var showingReminder = true
    @State private var showingPicker = false
    @State private var contentTitle = ""
    @State private var time = defaultReminderTime

    static var defaultReminderTime: Date{
        return Date()
    }
    
    static let types = ["To Build", "To Quit"]
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ZStack{
                    
                    VStack{
                        VStack(alignment: .leading, spacing: 20){

                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("What's Your Goal?")
                                    TextField("Add Name for the habit...", text: self.$name)
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
                            .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("Notes")
                                    TextField("Add a note describing it...", text: self.$note)
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }

                            ZStack {
                                RoundedRectangle(cornerRadius: 10, style: .circular)
                                    .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                    .frame(width: geo.size.width - 20, height: 80)
                                VStack(alignment: .leading){
                                    Text("The habit is to...")
                                    Picker("Choose type of Habit", selection: self.$type){
                                        ForEach(Self.types, id:\.self){
                                            Text($0)
                                        }
                                    }.pickerStyle(SegmentedPickerStyle())
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 40))
                            }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading){
                            Toggle(isOn: self.$showingReminder.animation()){
                                Text("Set a Reminder")
                            }
                            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            
                            if self.showingReminder{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                        .frame(width: geo.size.width - 20, height: 80)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "text.bubble")
                                            Text("Reminder Message")
                                        }
                                        TextField("Add a message for reminder...", text: self.$contentTitle)
                                    }
                                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                                }
                                
                                VStack (alignment: .leading){
                                    HStack{
                                        Image(systemName: "clock")
                                        Text("Reminder Time")
                                    }
                                    
                                    DatePicker("Select time", selection: self.$time, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(WheelDatePickerStyle())
                                }
                                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                            }
                        }
                        Spacer()
                    }
                }
            }
                
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                if self.name != "" && self.note != ""{
                    let item = Habit(type: self.type, name: self.name, note: self.note, startDate: Date())
                    self.habitItems.habits.append(item)
                    self.habitItems.setReminder(withHabitId: item.id, setValue: self.showingReminder, title: self.contentTitle, date: self.time)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .buttonStyle(PlainButtonStyle())
            )
        }
    }
}
struct HabitRowView: View {
    
    let habitItems: HabitItems
    let habit: Habit
    
    @State private var detailScreenIsPresented = false
    
    var body: some View {
        
        //GeometryReader{ geo in
        
            Button(action: {
                self.detailScreenIsPresented.toggle()
            }){
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
//                        .frame(width: 300, height: 80)
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(self.habit.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(self.habit.note)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(20)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing){
                                Button(action: {
                                    withAnimation{
                                        self.habitItems.complete(withHabitId: self.habit.id)
                                    }
                                }) {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(self.habit.hasCompletedForToday ? Color.green : Color.red)
                                            .frame(width: 44, height: 44)
                                        Image(systemName: "checkmark")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                                .disabled(self.habit.hasCompletedForToday)
                                .padding(20)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
            }
            .sheet(isPresented: self.$detailScreenIsPresented){
                HabitDetailView(habit: self.habit, habitItems: self.habitItems)
            }
//        }
    }
}
struct HabitDetailView: View {
    
    var habit: Habit
    let habitItems: HabitItems
    
    @Environment(\.presentationMode) var presentationMode
    
    var formatterDate: String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        
        print(habit.name, habit.id)
        
        return formatter.string(from: habit.startDate)
    }
    
    @State private var contentTitle = ""
    @State private var newTime = defaultReminderTime
    
    static var defaultReminderTime: Date{
        return Date()
    }
    
    
    var time: String{
        var hour = Calendar.current.component(.hour, from: self.habit.reminderTime!)
        let minute = Calendar.current.component(.minute, from: self.habit.reminderTime!)
        var holder = "AM"
        if hour > 12{
            hour -= 12
            holder = "PM"
        }
        return "\(hour):\(minute) \(holder)"
    }
    
    
    @State private var editReminder = false
    
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                Form{
                    Section(){
                        Text(self.habit.type)
                            .font(.headline)
                            .foregroundColor(Color.red)
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                        
                        Text(self.habit.note)
                            .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 0))
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    
                    Section(header: Text("Your Streaks")
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                        .font(.headline)
                    ){
                        HStack{
                            
                            VStack(){
                                Text("Best")
                                    .font(.title)
                                HStack(){
                                    Text("\(self.habit.bestStreak)")
                                        .font(.title)
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .foregroundColor(Color.init(red: 1, green: 215/255, blue: 0))
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
                            
                            Spacer()
                            
                            VStack(){
                                Text("Current")
                                    .font(.title)
                                HStack(){
                                    Text("\(self.habit.calculatedCurrentStreak)")
                                        .font(.title)
                                    Image(systemName: "star")
                                        .resizable()
                                        .foregroundColor(Color.init(red: 1, green: 215/255, blue: 0))
                                        .frame(width: 50, height: 50)
                                }
                            }
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))
                        }
                        .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                        
                        Text("You started on  \(self.formatterDate) and have \(self.habit.success*100, specifier: "%.2f")% success")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .italic()
                        .padding(.init(top: 20, leading: 20, bottom: 20, trailing: 20))
                        
                    }
                    
                    
                    Section(header: Text("Reminders")
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                        .font(.headline)
                    ){
                        Button(action: {
                            if self.habit.reminder!{
                                self.habitItems.setReminder(withHabitId: self.habit.id, setValue: false, title: self.habit.reminderTitle!, date: self.habit.reminderTime!)
                            }else{
                                self.habitItems.setReminder(withHabitId: self.habit.id, setValue: true, title: self.habit.reminderTitle!, date: self.habit.reminderTime!)
                            }
                        }){
                            if self.habit.reminder!{
                                Text("On")
                            }else{
                                Text("Off")
                            }
                        }
                        if self.habit.reminder!{
                            VStack{
                                HStack{
                                    Image(systemName: "bell.fill")
                                        .renderingMode(.original)
                                    Text("Daily at \(self.time)")
                                        .fontWeight(.heavy)
                                    
                                }
                                Text("Message -> \(self.habit.reminderTitle!)")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.secondary)
                            
                            
                            Button("Edit Time and Message"){
                                withAnimation{
                                    self.editReminder.toggle()
                                }
                            }
                            if self.editReminder{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10, style: .circular)
                                        .foregroundColor(Color.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 0.5))
                                        .frame(width: geo.size.width - 20, height: 80)
                                    VStack(alignment: .leading){
                                        HStack{
                                            Image(systemName: "text.bubble")
                                            Text("Reminder Message")
                                        }
                                        TextField("Add a message for reminder...", text: self.$contentTitle)
                                    }
                                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                                }
                                
                                ZStack {
                                    HStack{
                                        Image(systemName: "clock")
                                        Text("Reminder Time")
                                    }
                                    .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 40))
                                }
                                
                                DatePicker("Select time", selection: self.$newTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .datePickerStyle(WheelDatePickerStyle())
                                
                                Button("Save"){
                                    self.habitItems.setReminder(withHabitId: self.habit.id, setValue: self.habit.reminder!, title: self.contentTitle, date: self.newTime)
                                    self.editReminder = false
                                }
                                Button("Cancel"){
                                    self.editReminder = false
                                }
                                
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(habit.name)
            .navigationBarItems(trailing:
                Button("Delete"){
                    self.habitItems.remove(withHabitId: self.habit.id)
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
            
        }
    }
}

struct Goals: View {
    
    @State private var addMoreScreenIsPresented = false
    @ObservedObject var habitItems = HabitItems()
    
    var body: some View {
         ZStack{
            VStack{
                       
                               
                       
                       List{
                           ForEach(self.habitItems.habits, id: \.id){habit in
                               HabitRowView(habitItems: self.habitItems, habit: habit)
                           }
                       }
                   }
                   
                   VStack{
                       Spacer()
                       HStack{
                           Spacer()
                           
                           Button(action: {
                               self.addMoreScreenIsPresented.toggle()
                           }){
                               Text("+")
                                   .font(.largeTitle)
                           }
                           .foregroundColor(Color.white)
                           .frame(width: 80, height: 80)
                           .background(Color.blue)
                           .clipShape(Circle())
                           .padding()
                           .shadow(color: Color.black, radius: 10, x: 5, y: 5)
                       }
                   }
               }
               .sheet(isPresented: $addMoreScreenIsPresented){
                   AddHabit(habitItems: self.habitItems)
                   
               }
               .onAppear(perform: {
                   UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
                       if success{
                           print("Permission Granted")
                       }else if let error = error{
                           print(error.localizedDescription)
                       }
                   }
               })
        .navigationBarTitle("Goals")
        
    }
    
}

struct Goals_Previews: PreviewProvider {
    static var previews: some View {
        Goals()
    }
}
