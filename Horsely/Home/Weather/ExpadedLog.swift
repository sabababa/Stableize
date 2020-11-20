//
//  ExpadedLog.swift
//  Horsely
//
//  Created by Saba Dawit on 10/26/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
struct ExpadedLog: View {
  
    var body: some View {
         VStack{
            WebView(request: URLRequest(url: URL(string: "https://www.wunderground.com/health/us/ga/athens/30601")!))
        }
    .navigationBarTitle("Weather")
    }
}

struct ExpadedLog_Previews: PreviewProvider {
    static var previews: some View {
        ExpadedLog()
    }
}
