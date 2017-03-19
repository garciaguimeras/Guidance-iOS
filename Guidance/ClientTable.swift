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
    
    func getAllClientsFromTable(rows: Table) -> [Client] {
        var result: [Client] = []
        
        for item in try! db.prepare(rows) {
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
    
    func getClients() -> [Client] {
        return getAllClientsFromTable(table)
    }
    
    func getClientById(clientId: Int64) -> Client? {
        let row = table.filter(id == clientId)
        let clients = getAllClientsFromTable(row)
        if clients.count == 0 {
            return nil
        }
        return clients[0]
    }
    
    func addClient(client: Client, tourList: [ClientTour]) {
        let insert = table.insert(
            name <- client.name,
            country <- client.country,
            ages <- client.ages,
            meetPlace <- client.meetPlace,
            totalPersons <- client.totalPersons,
            comments <- client.comments
        )
        let id = try! db.run(insert)
        
        let ctTable = ClientTourTable()
        for ct in tourList {
            ct.clientId = id
            ct.id = 0
            ctTable.addClientTour(ct)
        }
    }
    
    func updateClient(client: Client, tourList: [ClientTour]) {
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
        
        // rewrite dependencies
        let ctTable = ClientTourTable()
        let tuples = ctTable.getClientToursByClient(client.id)
        for item in tuples {
            ctTable.deleteClientTour(item)
        }
    
        for ct in tourList {
            ct.clientId = client.id
            ct.id = 0
            ctTable.addClientTour(ct)
        }
    }
    
    func deleteClient(client: Client) {
        let row = table.filter(id == client.id)
        
        let ctTable = ClientTourTable()
        let tuples = ctTable.getClientToursByClient(client.id)
        for item in tuples {
            ctTable.deleteClientTour(item)
        }
        
        let delete = row.delete()
        try! db.run(delete)
    }
    
}