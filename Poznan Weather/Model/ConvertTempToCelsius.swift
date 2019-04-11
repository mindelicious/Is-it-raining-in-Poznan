//
//  ConvertTempToCelsius.swift
//  Poznan Weather
//
//  Created by Matt on 10/04/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//

import Foundation


func temperatureInCelsius(temperature: Double?) -> Double? {
    if temperature != nil {
        let celsiusTemperature = temperature! - 273.15
        return celsiusTemperature
    } else {
        return temperature
    }
    
}
