//
//  GuidanceTable.swift
//  Guidance
//
//  Created by Noel on 3/24/17.
//
//

import Foundation
import SQLite

class Guidance {
    var id: Int64 = 0
    var activationKey: String = ""
    var activationDate: NSDate?
    var version: String = ""
    var codeName: String = ""
    var secretKey: String = ""
}

class GuidanceTable: DbContext {
    
    var UNIQUE_ID: Int64 = 1
    var VERSION: String = "1.0.0"
    var CODE_NAME: String = "Murakami"
    var SECRET_KEY: String = "lucyinthesky"
    
    var id: Expression<Int64>
    var activationKey: Expression<String>
    var activationDate: Expression<NSDate?>
    var version: Expression<String>
    var codeName: Expression<String>
    var secretKey: Expression<String>
    
    init() {
        id = Expression<Int64>("id")
        activationKey = Expression<String>("activationKey")
        activationDate = Expression<NSDate?>("activationDate")
        version = Expression<String>("version")
        codeName = Expression<String>("codeName")
        secretKey = Expression<String>("secretKey")
        
        super.init(tableName: "guidance")
        
        initUniqueRecord()
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(activationKey)
            t.column(activationDate)
            t.column(version)
            t.column(codeName)
            t.column(secretKey)
        })
    }
    
    func getAppInfo() -> Guidance? {
        var result: [Guidance] = []
        
        let row = table.filter(id == UNIQUE_ID)
        for item in try! db.prepare(row) {
            let g = Guidance()
            g.id = item[id]
            g.activationKey = item[activationKey]
            g.activationDate = item[activationDate]
            g.version = item[version]
            g.codeName = item[codeName]
            g.secretKey = item[secretKey]
            result.append(g)
        }
        
        return result.count == 1 ? result[0] : nil
    }
    
    func initUniqueRecord() {
        let appInfo = getAppInfo()
        if appInfo != nil {
            return
        }
        
        let insert = table.insert(
            id <- UNIQUE_ID,
            activationKey <- "",
            version <- VERSION,
            codeName <- CODE_NAME,
            secretKey <- EncryptionUtils.dummy(SECRET_KEY)
        )
        try! db.run(insert)
    }
    
    func isActivated() -> Bool {
        let appInfo = getAppInfo()
        let activated = appInfo?.secretKey == appInfo?.activationKey
        return activated
    }
    
    func addActivationKey(key: String) -> Bool {
        if isActivated() {
            return true
        }
        
        let encrypted = EncryptionUtils.dummy(key)
        let appInfo = getAppInfo()
        if appInfo?.secretKey != encrypted {
            return false
        }
        
        let row = table.filter(id == UNIQUE_ID)
        let update = row.update(
            activationKey <- encrypted,
            activationDate <- NSDate()
        )
        try! db.run(update)
        return true
    }
    
}