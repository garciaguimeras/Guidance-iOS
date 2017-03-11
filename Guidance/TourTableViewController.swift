//
//  TourTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import UIKit

class TourTableViewController: UITableViewController {

    var tourTable = TourTable()
    var tours: [Tour]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tours = tourTable.getTours()
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
        return tours!.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TourCell", forIndexPath: indexPath)

        let tour = tours![indexPath.row] as Tour
        cell.textLabel?.text = tour.name
        cell.detailTextLabel?.text = tour.description

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
            let tour = tours![row]
            tourTable.deleteTour(tour)
            tours = tourTable.getTours()
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
        if segue.identifier == "editTour" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? TourDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPathForCell(cell!)!.row
            viewController!.tour = tours![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToTourTableViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveTourDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.sourceViewController as? TourDetailViewController {
            if let tour = viewController.tour {
                if tour.id == 0 {
                    // insert!
                    tourTable.addTour(tour)
                    tours = tourTable.getTours()
                    // udpate the table view
                    let index = NSIndexPath(forRow: tours!.count - 1, inSection: 0)
                    tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)                }
                else {
                    // update!
                    tourTable.updateTour(tour)
                    tours = tourTable.getTours()
                    // refresh
                    tableView.reloadData()
                }
            }
        }
    }
}
