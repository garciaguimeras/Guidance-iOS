//
//  DateUtils.swift
//  Guidance
//
//  Created by Noel on 3/19/17.
//
//

import Foundation

class DateUtils {
    
    class func fixDate(_ date: Date) -> Date {
        let calendar = Calendar.current
        let unit: NSCalendar.Unit = [.year, .month, .day]
        let components = (calendar as NSCalendar).components(unit, from: date)
        return calendar.date(from: components)!
    }
    
}
