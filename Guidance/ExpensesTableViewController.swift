//
//  ExpensesTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import UIKit

class ExpensesTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar?

    var expensesTable = ExpensesTable()
    var expenses: [Expenses]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchBar?.delegate = self
        expenses = expensesTable.getExpenses()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExpensesCell", forIndexPath: indexPath)

        let exp = expenses![indexPath.row] as Expenses
        
        cell.textLabel?.text = exp.description
        
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = "$\(exp.amount) el dia \(df.stringFromDate(exp.date!))"
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // remove!
            let row = indexPath.row
            let exp = expenses![row]
            expensesTable.deleteExpenses(exp)
            expenses = expensesTable.getExpenses()
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Search
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        expenses = expensesTable.getExpenses()
        if searchText != "" {
            expenses = expenses!.filter({(exp: Expenses) -> Bool in
                return exp.description.lowercaseString.rangeOfString((searchText.lowercaseString)) != nil
            })
        }
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editExpenses" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ExpensesDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPathForCell(cell!)!.row
            viewController!.exp = expenses![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToExpensesTableViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveExpensesDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.sourceViewController as? ExpensesDetailViewController {
            if let exp = viewController.exp {
                if exp.id == 0 {
                    // insert!
                    expensesTable.addExpenses(exp)
                    // udpate the table view
                    //let index = NSIndexPath(forRow: expenses!.count - 1, inSection: 0)
                    //tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)               
                }
                else {
                    // update!
                    expensesTable.updateExpenses(exp);
                }
                expenses = expensesTable.getExpenses()
                // refresh
                tableView.reloadData()
            }
        }
    }

}
