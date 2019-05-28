//
//  WeeklyWeather.swift
//  Poznan Weather
//
//  Created by Matt on 05/04/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeeklyWeather {
    
    var temperature: Double
    var pressure: Double
    var weatherIcon: String
    var date: Date
    var humidity: Int
    var minTemp: Double
    var maxTemp: Double
    var wind: Double
    var windDir: Double
    
    
    init(weatherDictionary: [String:Any]) {
        
        let json = JSON(weatherDictionary)
    
        self.temperature = temperatureInCelsius(temperature: json["temp"]["day"].doubleValue)!
        self.pressure = json["pressure"].doubleValue
        self.weatherIcon = json["weather"][0]["icon"].stringValue
        self.humidity = json["humidity"].intValue
        self.minTemp = temperatureInCelsius(temperature: json["temp"]["min"].doubleValue)!
        self.maxTemp = temperatureInCelsius(temperature: json["temp"]["max"].doubleValue)!
        self.wind = windMeterToKm(wind: json["speed"].doubleValue)!
        self.windDir = json["deg"].doubleValue
        if let date = json["dt"].double {
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self.date = rawDate
        } else {
         self.date = Date()
        }
        
    }
    
    class func downloadWeeklyWeather(completion: @escaping (_ weatherForcast: [WeeklyWeather]) -> Void) {
        
        let WEEKLYWEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?id=7530858&cnt=7&appid=ad4e521f54b155390c178acc59582f10"
        
        Alamofire.request(WEEKLYWEATHER_URL).responseJSON { (response) in
            
            let result = response.result
            var forecastArray: [WeeklyWeather] = []
            
            if result.isSuccess {
                
                if let dictionary = result.value as? [String:Any] {
                    if let list = dictionary["list"] as? [[String:Any]] {
                        for item in list {
                            let forecast = WeeklyWeather(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completion(forecastArray)
            }
            else {
                completion(forecastArray)
                print("No weekly Forecast")
            }
        }
    }
    
}

