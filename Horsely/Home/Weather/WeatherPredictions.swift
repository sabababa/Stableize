//
//  WeatherPredictions.swift
//  Horsely
//
//  Created by Saba Dawit on 9/22/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI

struct AirVisual : Decodable {
    let status: String?
    let data : Data?
    
    struct Data : Decodable {
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let location : Location?
    let forecasts: Forecasts?
    let current : Current?
    let history : History?
    
    struct Location: Decodable{
        let type: String?
        let coordinates: [Double]?
    }
    
    struct Forecasts : Decodable {
        let ts: String?
        let aqius: Int?
        let aqicn: Int?
        let tp: Int?
        let tp_min: Int?
        let pr: Int?
        let hu: Int?
        let ws: Int?
        let wd: Int?
        let ic: String?
    }
    
    struct Current : Decodable {
        let weather : Weather?
        let pollution : Pollution?
        struct Weather : Decodable {
            let ts: String?
            let tp: Int?
            let pr: Int?
            let hu: Int?
            let ws: Double?
            let wd: Int?
            let ic: String?
        }
        struct Pollution : Decodable {
            let ts: String?
            let aqius: Int?
            let mainus : String?
            let aqicn: Int?
            let maincn : String?
            let p2 : P2?
            struct P2 : Decodable {
                let conc : Int?
                let aqius: Int?
                let aqicn: Int?
            }
        }
    }
    
    struct History : Decodable {
        let weather : Weather?
        let poullution : Pollution?
        
        struct Weather : Decodable {
            let ts: String?
            let tp: Int?
            let pr: Int?
            let hu: Int?
            let ws: Int?
            let wd: Int?
            let ic: String?
        }
        struct Pollution : Decodable {
            let ts: String?
            let aqius: Int?
            let mainus : String?
            let aqicn: Int?
            let maincn : String?
            let p2 : P2?
            struct P2 : Decodable {
                let conc : Int?
                let aqius: Int?
                let aqicn: Int?
            }
        }
    }
    }
}

struct WeatherPredictions: View {
   let bgColors = [
     "Clear":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Sunny":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Partly cloudy":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Cloudy":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Overcast":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Mist":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Patchy rain possible":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Patchy snow possible":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Patchy sleet possible":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Patchy freezing drizzle possible":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Thundery outbreaks possible":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Blowing snow":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Blizzard":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Fog":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Freezing fog":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Patchy light drizzle":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Light rain":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Moderate rain at times":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Heavy rain":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Light freezing rain":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing),
     "Heavy rain at times":LinearGradient(gradient: Gradient(colors: [ColorManager.darkgreen, ColorManager.mintgreen]), startPoint: .leading, endPoint: .trailing)
     ]
     let icon = [
     "Clear": "moon.stars.fill",
     "Sunny": "sun.max.fill",
     "Partly cloudy Moon": "cloud.moon.fill",
     "Partly cloudy": "cloud.sun.fill",
     "Cloudy": "cloud.fill",
     "Overcast": "smoke.fill",
     "Mist": "cloud.fog.fill",
     "Patchy rain possible": "cloud.drizzle.fill",
     "Patchy snow possible": "cloud.hail.fill",
     "Patchy sleet possible": "cloud.sleet.fill",
     "Patchy freezing drizzle possible": "cloud.hail.fill",
     "Thundery outbreaks possible": "cloud.bolt.rain.fill",
     "Blowing snow": "cloud.snow.fill",
     "Blizzard": "wind.snow",
     "Fog": "cloud.fog.fill",
     "Freezing fog": "cloud.fog",
     "Patchy light drizzle": "cloud.drizzle.fill",
     "Light rain": "cloud.rain.fill",
     "Moderate rain at times": "cloud.rain.fill",
     "Heavy rain": "cloud.heavyrain.fill",
     "Light freezing rain": "cloud.hail.fill",
     "Heavy rain at times": "cloud.heavyrain.fill"
     ]
     @State var city = ""
     @State var temperature = 0
     @State var description = ""
     @State var imgData = Data()
     @State var getTemp = false
     @State var weatherDescription = "Clear"
    
     
        var body: some View {
        
         ZStack {
             bgColors[weatherDescription]
             VStack {
                
                     Text("\(city)")
                         .foregroundColor(Color.white)
                         .font(.system(size: 40))
                     Text("\(description)")
                         .foregroundColor(Color.white)
                         .font(.system(size: 25)).padding(.bottom, 60)
                         .frame(maxWidth: .infinity)
                     Image(systemName: icon[weatherDescription]!)
                         .foregroundColor(Color.white)
                         .font(.system(size: 120))
                     Text("\(self.temperature)")
                         .foregroundColor(Color.white)
                         .font(.system(size: 90))
                 
             }
             }.edgesIgnoringSafeArea(.all)
             .onAppear() {
                 self.getWeatherData()
             }
         }
            
     func getWeatherDescription (code : Int) -> String {
     switch code {
     case 113: return "Clear" // or Sunny
     case 116: return "Partly cloudy"
     case 119: return "Cloudy"
     case 122: return "Overcast"
     case 143: return "Mist"
     case 176: return "Patchy rain possible"
     case 179: return "Patchy snow possible"
     case 182: return "Patchy sleet possible"
     case 185: return "Patchy freezing drizzle possible"
     case 200: return "Thundery outbreaks possible"
     case 227: return "Blowing snow"
     case 230: return "Blizzard"
     case 248: return "Fog"
     case 260: return "Freezing fog"
     case 263: return "Patchy light drizzle"
     case 266: return "Light drizzle"
     case 281: return "Freezing drizzle"
     case 284: return "Heavy freezing drizzle"
     case 293: return "Patchy light rain"
     case 296: return "Light rain"
     case 299: return "Moderate rain at times"
     case 302: return "Moderate rain"
     case 305: return "Heavy rain at times"
     case 308: return "Heavy rain"
     case 311: return "Light freezing rain"
     default:
     return "Clear"
     }
     }
     
     
     
     func getWeatherData() {
        
         let jsonURLString = "http://api.airvisual.com/v2/nearest_city?key=4c8161da-99d8-4eb2-ae7a-3ee839d96723"
         // make URL
         guard let url = URL(string: jsonURLString) else { return }
         // create a session
         URLSession.shared.dataTask(with: url) { (data, response, error) in
             // check for error
             if error != nil {
                 print(error!.localizedDescription)
             }
             // check for 200 OK status
             guard let data = data else { return }
             do {
                 let weather = try JSONDecoder().decode(AirVisual.self, from: data)
                self.city = weather.data?.city ?? ""
                self.temperature = weather.data?.current?.weather?.tp ?? 0
                
                self.temperature = (self.temperature * 9/5) + 32
                 
                 self.getTemp.toggle()
             } catch let err {
                 print ("Json Err", err)
             }
             // start the session
         }.resume()
     }
}

struct WeatherPredictions_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPredictions()
    }
}
