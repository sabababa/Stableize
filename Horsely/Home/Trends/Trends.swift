//
//  Trends.swift
//  Horsely
//
//  Created by Saba Dawit on 9/24/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI

struct Trends: View {
    var body: some View {
            // 1
            TabView {
                // 2
                CalendarModuleView()
                    // 3
                    .tabItem {
                        VStack {
                            Text("Month")
                        }
                // 4
                }.tag(1)
                
                // 5
                VStack{
                    Text("Trends")
                        .fontWeight(.semibold)
                        .font(.system(size: 35))
                        .font(.title)
                        .padding(.top, -40)
                    WeeklyMood()
                }
                    .tabItem {
                        VStack {
                           
                            Text("Week")
                        }
                }.tag(2)
            }
        }
}

struct Trends_Previews: PreviewProvider {
    static var previews: some View {
        Trends()
    }
}
