//
//  TripTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/19/17.
//
//

import UIKit

class TripTableViewController: UITableViewController {
    
    var tripsByDate = Dictionary<NSDate, [ClientTour]>()
    var keys = Array<NSDate>()

    func reloadTripData() {
        tripsByDate = ClientTourTable().getClientToursAfterDate(NSDate())
        keys = tripsByDate.keys.sort({(d1: NSDate, d2: NSDate) -> Bool in
            let date1 = DateUtils.fixDate(d1)
            let date2 = DateUtils.fixDate(d2)
            return date1.timeIntervalSince1970 < date2.timeIntervalSince1970
        })
        tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadTripData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tripsByDate.keys.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let key = keys[section]
        return (tripsByDate[key]?.count)!
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = keys[section]
        let df = NSDateFormatter()
        df.dateFormat = "EEEE, MMMM dd"
        return df.stringFromDate(key)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripByDateCell", forIndexPath: indexPath) as! TripTableViewCell

        // Configure the cell...
        let key = keys[indexPath.section]
        let item = tripsByDate[key]![indexPath.row]
        
        let client = ClientTable().getClientById(item.clientId)
        let tour = TourTable().getTourById(item.tourId)
        let guide = GuideTable().getGuideById(item.guideId)
        let driver = DriverTable().getDriverById(item.driverId)
        
        cell.clientName!.text = client?.name
        cell.tourName!.text = tour?.name
        cell.guideName!.text = guide?.name
        cell.driverName!.text = driver?.name
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
