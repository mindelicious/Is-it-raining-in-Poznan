//
//  convertWindFromMeterToKm.swift
//  Poznan Weather
//
//  Created by Matt on 14/04/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//

import Foundation

func windMeterToKm(wind: Double?) -> Double?{
    if wind != nil {
        let kmWind = wind! * 3.6
        return kmWind
    } else {
        return wind
    }
}
