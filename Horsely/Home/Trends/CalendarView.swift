//
//  CalendarView.swift
//  Horsely
//
//  Created by Saba Dawit on 9/24/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import FSCalendar
import FirebaseDatabase
import FirebaseAuth

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
        print(self.date)
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
   var ref = Database.database().reference()
   let user = Auth.auth().currentUser
    
    
    var body: some View {
        VStack{
           Text("Monthly View")
            .fontWeight(.semibold)
            .font(.system(size: 35))
            .font(.title)
            CalendarModuleViewController()
            
            NewMood(date: get.init().date, mood: "", triggers: "", dV: true)
       
        }.padding(.top, -50)
    }
    
    
}

struct CalendarModuleView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarModuleView()
  }
}
