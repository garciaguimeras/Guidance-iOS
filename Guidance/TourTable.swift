//
//  TourTable.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import Foundation
import SQLite

class Tour {
    var id: Int64 = 0
    var name: String = ""
    var description: String = ""
}

class TourTable: DbContext {
    
    var id: Expression<Int64>
    var name: Expression<String>
    var description: Expression<String>
    
    init() {
        id = Expression<Int64>("id")
        name = Expression<String>("name")
        description = Expression<String>("description")
        
        super.init(tableName: "tour")
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(description)
            })
    }
    
    func getAllToursFromTable(rows: Table) -> [Tour] {
        var result: [Tour] = []
        
        for item in try! db.prepare(rows) {
            let tour = Tour()
            tour.id = item[id]
            tour.name = item[name]
            tour.description = item[description]
            result.append(tour)
        }
        
        return result
    }
    
    func getTours() -> [Tour] {
        return getAllToursFromTable(table)
    }
    
    func getTourById(tourId: Int64) -> Tour? {
        let row = table.filter(id == tourId)
        let tours = getAllToursFromTable(row)
        if tours.count == 0 {
            return nil
        }
        return tours[0]
    }
    
    func addTour(tour: Tour) {
        let insert = table.insert(
            name <- tour.name,
            description <- tour.description
        )
        try! db.run(insert)
    }
    
    func updateTour(tour: Tour) {
        let row = table.filter(id == tour.id)
        let update = row.update(
            name <- tour.name,
            description <- tour.description
        )
        try! db.run(update)
    }
    
    func deleteTour(tour: Tour) {
        let row = table.filter(id == tour.id)
        
        let ctTable = ClientTourTable()
        let tuples = ctTable.getClientToursByTour(tour.id)
        for item in tuples {
            ctTable.deleteClientTour(item)
        }
        
        let delete = row.delete()
        try! db.run(delete)
    }
    
}