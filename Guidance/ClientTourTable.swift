//
//  ClientTourTable.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import Foundation
import SQLite

class ClientTour {
    var id: Int64 = 0
    
    var clientId: Int64 = 0
    var tourId: Int64 = 0
    var guideId: Int64 = 0
    var driverId: Int64 = 0
    
    var price: Double = 0
    var driverCommission: Double = 0
    var guideCommission: Double = 0
    
    var notifyDriver: Bool = false
    var notifyGuide: Bool = false
    
    var payDriver: Bool = false
    var payGuide: Bool = false
    
    var fromOutsiderCompany: Bool = false
    
    var date: Date? = nil
    var comments: String = ""
}

class ClientTourTable: DbContext {
    
    var id: Expression<Int64>
    
    var clientId: Expression<Int64>
    var tourId: Expression<Int64>
    var guideId: Expression<Int64>
    var driverId: Expression<Int64>
    
    var price: Expression<Double>
    var driverCommission: Expression<Double>
    var guideCommission: Expression<Double>
    
    var notifyDriver: Expression<Bool>
    var notifyGuide: Expression<Bool>
    
    var payDriver: Expression<Bool>
    var payGuide: Expression<Bool>
    
    var fromOutsiderCompany: Expression<Bool>
    
    var date: Expression<Date?>
    var comments: Expression<String>
    
    init() {
        id = Expression<Int64>("id")
        
        clientId = Expression<Int64>("clientId")
        tourId = Expression<Int64>("tourId")
        guideId = Expression<Int64>("guideId")
        driverId = Expression<Int64>("driverId")

        price = Expression<Double>("price")
        driverCommission = Expression<Double>("driverCommission")
        guideCommission = Expression<Double>("guideCommission")
        
        notifyDriver = Expression<Bool>("notifyDriver")
        notifyGuide = Expression<Bool>("notifyGuide")
        
        payDriver = Expression<Bool>("payDriver")
        payGuide = Expression<Bool>("payGuide")
        
        fromOutsiderCompany = Expression<Bool>("fromOutsiderCompany")
        
        date = Expression<Date?>("date")
        comments = Expression<String>("comments")
        
        super.init(tableName: "clientTour")
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(clientId)
            t.column(tourId)
            t.column(guideId)
            t.column(driverId)
            t.column(price)
            t.column(driverCommission)
            t.column(guideCommission)
            t.column(notifyDriver)
            t.column(notifyGuide)
            t.column(payDriver)
            t.column(payGuide)
            t.column(fromOutsiderCompany)
            t.column(date)
            t.column(comments)
        })
    }
    
    func getAllFromTable(_ rows: Table) -> [ClientTour] {
        var result: [ClientTour] = []
        
        let ordered = rows.order(date)
        for item in try! db.prepare(ordered) {
            let ct = ClientTour()
            ct.id = item[id]
            ct.clientId = item[clientId]
            ct.tourId = item[tourId]
            ct.guideId = item[tourId]
            ct.driverId = item[driverId]
            ct.price = item[price]
            ct.driverCommission = item[driverCommission]
            ct.guideCommission = item[guideCommission]
            ct.notifyDriver = item[notifyDriver]
            ct.notifyGuide = item[notifyGuide]
            ct.payDriver = item[payDriver]
            ct.payGuide = item[payGuide]
            ct.fromOutsiderCompany = item[fromOutsiderCompany]
            ct.date = item[date]
            ct.comments = item[comments]
            result.append(ct)
        }
        
        return result
    }
    
    func getClientToursByClient(_ clientId: Int64) -> [ClientTour] {
        let rows = table.filter(clientId == self.clientId)
        return getAllFromTable(rows)
    }
    
    func getClientToursByTour(_ tourId: Int64) -> [ClientTour] {
        let rows = table.filter(tourId == self.tourId)
        return getAllFromTable(rows)
    }
    
    func getClientToursByGuide(_ guideId: Int64) -> [ClientTour] {
        let rows = table.filter(guideId == self.guideId)
        return getAllFromTable(rows)
    }
    
    func getClientToursByDriver(_ driverId: Int64) -> [ClientTour] {
        let rows = table.filter(driverId == self.driverId)
        return getAllFromTable(rows)
    }
    
    func getClientToursAfterDate(_ date: Date) -> Dictionary<Date, [ClientTour]> {
        var result = Dictionary<Date, [ClientTour]>()
        
        let paramDate = DateUtils.fixDate(date)
        let rows = table.filter(self.date >= paramDate)
        let tripList = getAllFromTable(rows)
        for item in tripList {
            let d = DateUtils.fixDate(item.date!)
            let arr = result[d]
            if arr == nil {
                result[d] = []
            }
            result[d]!.append(item)
        }
        
        return result
    }
    
    func getClientTours(forLastMonths totalMonths: Int) -> Dictionary<Date, [ClientTour]> {
        var result = Dictionary<Date, [ClientTour]>()
        
        // TODO: Fix this
        var date = DateUtils.getInitialDayOfPrevMonth(forDate: Date())
        var count = 0
        while count < totalMonths {
            let (initDate, finalDate) = DateUtils.getMonthInterval(forDate: date)
            let rows = table.filter(self.date >= initDate && self.date < finalDate)
            
            let tripList = getAllFromTable(rows)
            result[date] = tripList
            
            count = count + 1
            date = DateUtils.getInitialDayOfPrevMonth(forDate: date)
        }
        
        return result
    }
    
    func addClientTour(_ ct: ClientTour) {
        let insert = table.insert(
            clientId <- ct.clientId,
            tourId <- ct.tourId,
            guideId <- ct.guideId,
            driverId <- ct.driverId,
            price <- ct.price,
            driverCommission <- ct.driverCommission,
            guideCommission <- ct.guideCommission,
            notifyDriver <- ct.notifyDriver,
            notifyGuide <- ct.notifyGuide,
            payDriver <- ct.payDriver,
            payGuide <- ct.payGuide,
            fromOutsiderCompany <- ct.fromOutsiderCompany,
            date <- ct.date,
            comments <- ct.comments
        )
        try! db.run(insert)
    }
    
    func updateClientTour(_ ct: ClientTour) {
        let row = table.filter(id == ct.id)
        let update = row.update(
            clientId <- ct.clientId,
            tourId <- ct.tourId,
            guideId <- ct.guideId,
            driverId <- ct.driverId,
            price <- ct.price,
            driverCommission <- ct.driverCommission,
            guideCommission <- ct.guideCommission,
            notifyDriver <- ct.notifyDriver,
            notifyGuide <- ct.notifyGuide,
            payDriver <- ct.payDriver,
            payGuide <- ct.payGuide,
            fromOutsiderCompany <- ct.fromOutsiderCompany,
            date <- ct.date,
            comments <- ct.comments
        )
        try! db.run(update)
    }
    
    func deleteClientTour(_ ct: ClientTour) {
        let row = table.filter(id == ct.id)
        let delete = row.delete()
        try! db.run(delete)
    }
    
}
