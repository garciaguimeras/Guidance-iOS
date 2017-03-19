//
//  DriverTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import UIKit

class DriverTableViewController: UITableViewController {
    
    var driverTable = DriverTable()
    var drivers: [Driver]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        drivers = driverTable.getDrivers()
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
        return drivers!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DriverCell", forIndexPath: indexPath)

        let driver = drivers![indexPath.row] as Driver
        cell.textLabel?.text = driver.name
        cell.detailTextLabel?.text = "\(driver.carType), evaluado con \(driver.rate)"
        
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
            let driver = drivers![indexPath.row]
            driverTable.deleteDriver(driver)
            drivers = driverTable.getDrivers()
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editDriver" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? DriverDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPathForCell(cell!)!.row
            viewController!.driver = drivers![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToDriversTableViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveDriverDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.sourceViewController as? DriverDetailViewController {
            if let driver = viewController.driver {
                if driver.id == 0 {
                    // insert!
                    driverTable.addDriver(driver)
                    drivers = driverTable.getDrivers()
                    // udpate the table view
                    let index = NSIndexPath(forRow: drivers!.count - 1, inSection: 0)
                    tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)
                }
                else {
                    // update!
                    driverTable.updateDriver(driver)
                    drivers = driverTable.getDrivers()
                    // refresh
                    tableView.reloadData()
                }
            }
        }
    }
}
