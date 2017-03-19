//
//  ClientTourTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/15/17.
//
//

import UIKit

class ClientTourTableViewController: UITableViewController {
    
    var table = ClientTourTable()
    var list: [ClientTour]?
    
    var clientId: Int64?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        list = table.getClientToursByClient(clientId!)
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
        return list!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell", forIndexPath: indexPath)

        // Configure the cell...
        let ct = list![indexPath.row] as ClientTour
        var tour: Tour? = nil
        if ct.tourId != 0 {
            let tourTable = TourTable()
            tour = tourTable.getTourById(ct.tourId)
        }
        cell.textLabel?.text = tour != nil ? tour?.name : ""
        
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = String(df.stringFromDate(ct.date!))

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
            let row = indexPath.row
            let ct = list![row]
            table.deleteClientTour(ct)
            list = table.getClientToursByClient(clientId!)
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
        if segue.identifier == "editTrip" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPathForCell(cell!)!.row
            viewController!.ct = list![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToClientTourTableViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveClientTourDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.sourceViewController as? ClientTourDetailViewController {
            if let ct = viewController.ct {
                ct.clientId = clientId!
                if ct.id == 0 {
                    // insert!
                    table.addClientTour(ct)
                    list = table.getClientToursByClient(clientId!)
                    // udpate the table view
                    let index = NSIndexPath(forRow: list!.count - 1, inSection: 0)
                    tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)                }
                else {
                    // update!
                    table.updateClientTour(ct)
                    list = table.getClientToursByClient(clientId!)
                    // refresh
                    tableView.reloadData()
                }
            }
        }
    }

}
