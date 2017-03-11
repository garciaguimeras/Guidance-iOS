//
//  ExpensesTable.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import Foundation
import SQLite

class Expenses {
    var id: Int64 = 0
    var date: NSDate?
    var description: String = ""
    var amount: Double = 0
}

class ExpensesTable: DbContext {
    
    var id: Expression<Int64>
    var date: Expression<NSDate?>
    var description: Expression<String>
    var amount: Expression<Double>
    
    init() {
        id = Expression<Int64>("id")
        date = Expression<NSDate?>("date")
        description = Expression<String>("description")
        amount = Expression<Double>("amount")
        
        super.init(tableName: "expenses")
    }
    
    override func createTable() {
        try! db.run(table.create { t in
            t.column(id, primaryKey: true)
            t.column(date)
            t.column(description)
            t.column(amount)
            })
    }
    
    func getExpenses() -> [Expenses] {
        var result: [Expenses] = []
        
        for item in try! db.prepare(table) {
            let expenses = Expenses()
            expenses.id = item[id]
            expenses.date = item[date]
            expenses.description = item[description]
            expenses.amount = item[amount]
            result.append(expenses)
        }
        
        return result
    }
    
    func addExpenses(expenses: Expenses) {
        let insert = table.insert(
            date <- expenses.date,
            description <- expenses.description,
            amount <- expenses.amount
        )
        try! db.run(insert)
    }
    
    func updateExpenses(expenses: Expenses) {
        let row = table.filter(id == expenses.id)
        let update = row.update(
            date <- expenses.date,
            description <- expenses.description,
            amount <- expenses.amount
        )
        try! db.run(update)
    }
    
    func deleteExpenses(expenses: Expenses) {
        let row = table.filter(id == expenses.id)
        let delete = row.delete()
        try! db.run(delete)
    }
    
}