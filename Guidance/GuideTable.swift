//
//  GuideTable.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import Foundation
import SQLite

class Guide {
    var id: Int64 = 0
    var name: String = ""
    var mobile: String = ""
    var phone: String = ""
    var address: String = ""
    var profession: String = ""
    var skills: String = ""
    var isFavorite: Bool = false
}

class GuideTable: DbContext {
    
    var id: Expression<Int64>
    var name: Expression<String>
    var mobile: Expression<String>
    var phone: Expression<String>
    var address: Expression<String>
    var profession: Expression<String>
    var skills: Expression<String>
    var isFavorite: Expression<Bool>

    init() {
        id = Expression<Int64>("id")
        name = Expression<String>("name")
        mobile = Expression<String>("mobile")
        phone = Expression<String>("phone")
        address = Expression<String>("address")
        profession = Expression<String>("profession")
        skills = Expression<String>("skills")
        isFavorite = Expression<Bool>("isFavorite")
        
        super.init(tableName: "guide")
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(mobile)
            t.column(phone)
            t.column(address)
            t.column(profession)
            t.column(skills)
            t.column(isFavorite)
        })
    }
    
    func getAllGuidesFromTable(rows: Table) -> [Guide] {
        var result: [Guide] = []
        
        let ordered = rows.order(name)
        for item in try! db.prepare(ordered) {
            let g = Guide()
            g.id = item[id]
            g.name = item[name]
            g.mobile = item[mobile]
            g.phone = item[phone]
            g.address = item[address]
            g.profession = item[profession]
            g.skills = item[skills]
            g.isFavorite = item[isFavorite]
            result.append(g)
        }
        
        return result
    }
    
    func getGuides() -> [Guide] {
        return getAllGuidesFromTable(table)
    }
    
    func getGuideById(guideId: Int64) -> Guide? {
        let rows = table.filter(id == guideId)
        let guides = getAllGuidesFromTable(rows)
        if guides.count == 0 {
            return nil
        }
        return guides[0]
    }
    
    func addGuide(g: Guide) {
        let insert = table.insert(
            name <- g.name,
            mobile <- g.mobile,
            phone <- g.phone,
            address <- g.address,
            profession <- g.profession,
            skills <- g.skills,
            isFavorite <- g.isFavorite
        )
        try! db.run(insert)
    }
    
    func updateGuide(g: Guide) {
        let row = table.filter(id == g.id)
        let update = row.update(
            name <- g.name,
            mobile <- g.mobile,
            phone <- g.phone,
            address <- g.address,
            profession <- g.profession,
            skills <- g.skills,
            isFavorite <- g.isFavorite
        )
        try! db.run(update)
    }
    
    func deleteGuide(g: Guide) {
        let row = table.filter(id == g.id)
        
        let ctTable = ClientTourTable()
        let tuples = ctTable.getClientToursByGuide(g.id)
        for item in tuples {
            ctTable.deleteClientTour(item)
        }
        
        let delete = row.delete()
        try! db.run(delete)
    }
    
}