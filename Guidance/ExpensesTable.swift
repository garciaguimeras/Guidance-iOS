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
    var date: Date?
    var description: String = ""
    var amount: Double = 0
}

class ExpensesTable: DbContext {
    
    var id: Expression<Int64>
    var date: Expression<Date?>
    var description: Expression<String>
    var amount: Expression<Double>
    
    init() {
        id = Expression<Int64>("id")
        date = Expression<Date?>("date")
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
    
    func getAllExpensesFromTable(_ rows: Table) -> [Expenses] {
        var result: [Expenses] = []
        
        let ordered = rows.order(date.desc)
        for item in try! db.prepare(ordered) {
            let expenses = Expenses()
            expenses.id = item[id]
            expenses.date = item[date]
            expenses.description = item[description]
            expenses.amount = item[amount]
            result.append(expenses)
        }
        
        return result
    }
    
    func getExpenses() -> [Expenses] {
        return getAllExpensesFromTable(table)
    }
    
    func getExpenses(forLastMonths totalMonths: Int) -> Dictionary<Date, [Expenses]> {
        var result = Dictionary<Date, [Expenses]>()
        
        // TODO: Fix this
        var date = DateUtils.getInitialDayOfPrevMonth(forDate: Date())
        var count = 0
        while count < totalMonths {
            let (initDate, finalDate) = DateUtils.getMonthInterval(forDate: date)
            let rows = table.filter(self.date >= initDate && self.date < finalDate)
            
            let list = getAllExpensesFromTable(rows)
            result[date] = list
            
            count = count + 1
            date = DateUtils.getInitialDayOfPrevMonth(forDate: date)
        }
        
        return result
    }
    
    func addExpenses(_ expenses: Expenses) {
        let insert = table.insert(
            date <- expenses.date,
            description <- expenses.description,
            amount <- expenses.amount
        )
        try! db.run(insert)
    }
    
    func updateExpenses(_ expenses: Expenses) {
        let row = table.filter(id == expenses.id)
        let update = row.update(
            date <- expenses.date,
            description <- expenses.description,
            amount <- expenses.amount
        )
        try! db.run(update)
    }
    
    func deleteExpenses(_ expenses: Expenses) {
        let row = table.filter(id == expenses.id)
        let delete = row.delete()
        try! db.run(delete)
    }
    
}
