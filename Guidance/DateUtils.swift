//
//  DateUtils.swift
//  Guidance
//
//  Created by Noel on 3/19/17.
//
//

import Foundation

class DateUtils {
    
    class func fixDate(date: NSDate) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let unit: NSCalendarUnit = [.Year, .Month, .Day]
        let components = calendar.components(unit, fromDate: date)
        return calendar.dateFromComponents(components)!
    }
    
}