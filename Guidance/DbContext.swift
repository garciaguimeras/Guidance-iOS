//
//  DbContext.swift
//  Guidance
//
//  Created by Noel on 3/7/17.
//
//

import Foundation
import SQLite

class DbContext {
    
    var db: Connection
    var table: Table
    var tableName: String
    
    init(tableName: String) {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        self.db = try! Connection("\(path)/Guidance.sqlite3", readonly: false)

        self.tableName = tableName
        self.table = Table(tableName)
        
        if !tableExist() {
            createTable()
        }
    }
    
    func tableExist() -> Bool {
        let count: Int64 = db.scalar("SELECT EXISTS(SELECT name FROM sqlite_master WHERE name = ?)", tableName) as! Int64
        
        return count != 0
    }
    
    func createTable() {
        preconditionFailure("This method must be overriden")
    }

}