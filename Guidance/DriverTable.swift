//
//  DriverTable.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import Foundation
import SQLite

class Driver {
    var id: Int64 = 0
    var name: String = ""
    var mobile: String = ""
    var phone: String = ""
    var address: String = ""
    var carType: String = ""
    var rate: Int = 0
}

class DriverTable: DbContext {
    
    var id: Expression<Int64>
    var name: Expression<String>
    var mobile: Expression<String>
    var phone: Expression<String>
    var address: Expression<String>
    var carType: Expression<String>
    var rate: Expression<Int>
    
    init() {
        id = Expression<Int64>("id")
        name = Expression<String>("name")
        mobile = Expression<String>("mobile")
        phone = Expression<String>("phone")
        address = Expression<String>("address")
        carType = Expression<String>("carType")
        rate = Expression<Int>("rate")
        
        super.init(tableName: "driver")
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(mobile)
            t.column(phone)
            t.column(address)
            t.column(carType)
            t.column(rate)
        })
    }
    
    func getAllDriversFromTable(rows: Table) -> [Driver] {
        var result: [Driver] = []
        
        for item in try! db.prepare(rows) {
            let d = Driver()
            d.id = item[id]
            d.name = item[name]
            d.mobile = item[mobile]
            d.phone = item[phone]
            d.address = item[address]
            d.carType = item[carType]
            d.rate = item[rate]
            result.append(d)
        }
        
        return result
    }
    
    func getDrivers() -> [Driver] {
        return getAllDriversFromTable(table)
    }
    
    func getDriverById(driverId: Int64) -> Driver? {
        let rows = table.filter(id == driverId)
        let drivers = getAllDriversFromTable(rows)
        if drivers.count == 0 {
            return nil
        }
        return drivers[0]
    }
    
    func addDriver(d: Driver) {
        let insert = table.insert(
            name <- d.name,
            mobile <- d.mobile,
            phone <- d.phone,
            address <- d.address,
            carType <- d.carType,
            rate <- d.rate
        )
        try! db.run(insert)
    }
    
    func updateDriver(d: Driver) {
        let row = table.filter(id == d.id)
        let update = row.update(
            name <- d.name,
            mobile <- d.mobile,
            phone <- d.phone,
            address <- d.address,
            carType <- d.carType,
            rate <- d.rate
        )
        try! db.run(update)
    }
    
    func deleteDriver(d: Driver) {
        let row = table.filter(id == d.id)
        
        let ctTable = ClientTourTable()
        let tuples = ctTable.getClientToursByDriver(d.id)
        for item in tuples {
            ctTable.deleteClientTour(item)
        }
        
        let delete = row.delete()
        try! db.run(delete)
    }
    
}