//
//  DateExtension.swift
//  Poznan Weather
//
//  Created by Matt on 10/04/2019.
//  Copyright © 2019 mindelicious. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pl_PL_POSIX")
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
    
    func singleDayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pl_PL_POSIX")
        dateFormatter.dateFormat = "dd MMM EEEE"
        
        return dateFormatter.string(from: self)
    }
    
}
