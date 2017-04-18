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
    
    class func getInitialDayOfMonth(forDate date: Date) -> Date {
        let calendar = Calendar.current
        let initDate = calendar.date(bySetting: .day, value: 1, of: fixDate(date))!
        return initDate
    }
    
    class func getInitialDayOfPrevMonth(forDate date: Date) -> Date {
        let calendar = Calendar.current
        let initDate = calendar.date(bySetting: .day, value: 1, of: fixDate(date))!
        let prevInitDate = calendar.date(byAdding: .month, value: -1, to: initDate)!
        return prevInitDate
    }
    
    class func getMonthInterval(forDate date: Date) -> (Date, Date) {
        let calendar = Calendar.current
        let initDate = calendar.date(bySetting: .day, value: 1, of: fixDate(date))!
        let finalDate = calendar.date(byAdding: .month, value: 1, to: initDate)!
        return (initDate, finalDate)
    }
    
}
