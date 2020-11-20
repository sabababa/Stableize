//
//  CalendarView.swift
//  Horsely
//
//  Created by Saba Dawit on 9/24/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import FSCalendar

class CalendarModule: UIViewController, FSCalendarDelegate {
    
    var calendar = FSCalendar()
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initCalendar()
        view.addSubview(calendar)
    }
    
    private func initCalendar() {
        calendar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
        calendar.appearance.todayColor = UIColor.systemGreen
        calendar.appearance.selectionColor = UIColor.systemBlue
    }
}

class get {
    var date : Date
    let calen = CalendarModule()
    init() {
        self.date = calen.calendar.selectedDate ?? Date()
    }
}
struct CalendarModuleViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CalendarModuleViewController>) -> UIViewController {
        let viewController = CalendarModule()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CalendarModuleViewController>) {
    
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    final class Coordinator: NSObject, FSCalendarDelegate {
        private var parent: CalendarModuleViewController
        
        
        init (_ parent: CalendarModuleViewController) {
            self.parent = parent
        }
        
    }
}

struct CalendarModuleView: View {
    let cal = CalendarModule()
   
    @Environment(\.managedObjectContext) var managedObjectContext
          // 1.
          @FetchRequest(
            // 2.
            entity: Daily.entity(),
            // 3.
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Daily.date, ascending: true)
            ], predicate: NSPredicate(format: "date >= %@", Calendar.current.startOfDay(for: get.init().date) as NSDate)
            // 4.
    )
    var reminders: FetchedResults<Daily>
    var body: some View {
        VStack{
           Text("Monthly View")
            .fontWeight(.semibold)
            .font(.system(size: 35))
            .font(.title)
            CalendarModuleViewController()
            
            ForEach(reminders, id: \.date) {
            NewMood(daily: $0)
            }
       
        }.padding(.top, -50)
    }
    
    func selectedDate()-> Date{
        return cal.calendar.selectedDate ?? Date()
    }
}

struct CalendarModuleView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarModuleView()
  }
}
