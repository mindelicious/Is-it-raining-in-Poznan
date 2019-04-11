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
    
    var _temperature: Double!
    var _pressure: Int!
    var _condition: Int!
    var _weatherIcon: String!
    var _date: Date!
    
    
    var temperature: Double {
        if _temperature == nil {
            _temperature = 0
        }
        return _temperature
    }
    
    var pressure: Int {
        if _pressure == nil {
            _pressure = 666
        }
        return _pressure
    }
    var condition: Int {
        if _condition == nil {
            _condition = 666
        }
        return _condition
    }
    
    var weatherIcon: String {
        guard _weatherIcon == nil else {
            _weatherIcon = ""
            return _weatherIcon
        }
        return _weatherIcon
    }
    
    var date: Date {
        guard _date == nil else {
            _date = Date()
            return _date
        }
        return _date
    }
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        
        let json = JSON(weatherDictionary)
        print(json)
        self._temperature = temperatureInCelsius(temperature: json["temp"]["day"].double)
        self._pressure = json["pressure"].intValue
        self._weatherIcon = json["weather"][0]["icon"].stringValue
        if let date = json["dt"].double {
            let rawDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self._date = rawDate
        }
        
    }
    
    class func downloadWeeklyWeather(completion: @escaping (_ weatherForcast: [WeeklyWeather]) -> Void) {
        
        let WEEKLYWEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?id=7530858&cnt=7&appid=ad4e521f54b155390c178acc59582f10"
        
        Alamofire.request(WEEKLYWEATHER_URL).responseJSON { (response) in
            
            let result = response.result
            var forecastArray: [WeeklyWeather] = []
            
            if result.isSuccess {
                
                if let dictionary = result.value as? Dictionary<String, AnyObject> {
                    if let list = dictionary["list"] as? [Dictionary<String, AnyObject>] {
                        
                        print("number of days:", list.count)
                        
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

