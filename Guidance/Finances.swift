//
//  Finances.swift
//  Guidance
//
//  Created by Noel on 4/17/17.
//
//

import Foundation

class Finances {
    var monthFirstDate: Date?
    var tripProfits: Double = 0
    var guideCommissions: Double = 0
    var driverCommissions: Double = 0
    var otherExpenses: Double = 0
}

class FinancesManager {
    
    class func getFinances(forLastMonths months: Int) -> [Finances] {
        var result = Dictionary<Date, Finances>()
        
        let tripsDict = ClientTourTable().getClientTours(forLastMonths: months)
        for date in tripsDict.keys {
            if result[date] == nil {
                result[date] = Finances()
                result[date]!.monthFirstDate = date
            }
            
            for trip in tripsDict[date]! {
                result[date]!.tripProfits += trip.price
                if trip.payGuide {
                    result[date]!.guideCommissions += trip.guideCommission
                }
                if trip.payDriver {
                    result[date]!.driverCommissions += trip.driverCommission
                }
            }
        }
        
        let expensesDict = ExpensesTable().getExpenses(forLastMonths: months)
        for date in expensesDict.keys {
            if result[date] == nil {
                result[date] = Finances()
                result[date]!.monthFirstDate = date
            }
            
            for exp in expensesDict[date]! {
                result[date]!.otherExpenses += exp.amount
            }
        }
        
        var list: [Finances] = []
        for date in result.keys {
            list.append(result[date]!)
        }
        list.sort(by: { (f1: Finances, f2: Finances) -> Bool in
            return f1.monthFirstDate! > f2.monthFirstDate!
        })
        
        return list
    }
    
}
