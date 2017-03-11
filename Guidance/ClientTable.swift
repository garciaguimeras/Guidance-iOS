//
//  Client.swift
//  Guidance
//
//  Created by Noel on 3/7/17.
//
//

import Foundation
import SQLite

class Client {
    var id: Int64 = 0
    var name: String = ""
    var country: String = ""
    var ages: String = ""
    var meetPlace: String = ""
    var totalPersons: Int = 0
    var comments: String = ""
}

class ClientTable: DbContext {
    
    var id: Expression<Int64>
    var name: Expression<String>
    var country: Expression<String>
    var ages: Expression<String>
    var meetPlace: Expression<String>
    var totalPersons: Expression<Int>
    var comments: Expression<String>
    
    init() {
        id = Expression<Int64>("id")
        name = Expression<String>("name")
        country = Expression<String>("country")
        ages = Expression<String>("ages")
        meetPlace = Expression<String>("meetPlace")
        totalPersons = Expression<Int>("totalPersons")
        comments = Expression<String>("comments")
        
        super.init(tableName: "client")
    }
  
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(country)
            t.column(ages)
            t.column(meetPlace)
            t.column(totalPersons)
            t.column(comments)
        })
    }
    
    func getClients() -> [Client] {
        var result: [Client] = []
        
        for item in try! db.prepare(table) {
           let client = Client()
            client.id = item[id]
            client.name = item[name]
            client.country = item[country]
            client.ages = item[ages]
            client.meetPlace = item[meetPlace]
            client.totalPersons = item[totalPersons]
            client.comments = item[comments]
            result.append(client)
        }
        
        return result
    }
    
    func addClient(client: Client) {
        let insert = table.insert(
            name <- client.name,
            country <- client.country,
            ages <- client.ages,
            meetPlace <- client.meetPlace,
            totalPersons <- client.totalPersons,
            comments <- client.comments
        )
        try! db.run(insert)
    }
    
    func updateClient(client: Client) {
        let row = table.filter(id == client.id)
        let update = row.update(
            name <- client.name,
            country <- client.country,
            ages <- client.ages,
            meetPlace <- client.meetPlace,
            totalPersons <- client.totalPersons,
            comments <- client.comments
        )
        try! db.run(update)
    }
    
    func deleteClient(client: Client) {
        let row = table.filter(id == client.id)
        let delete = row.delete()
        try! db.run(delete)
    }
    
}