//
//  TripTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/19/17.
//
//

import UIKit

class TripTableViewController: UITableViewController {
    
    var tripsByDate = Dictionary<Date, [ClientTour]>()
    var keys = Array<Date>()
    
    var date: Date = Date()

    func reloadTripData() {
        tripsByDate = ClientTourTable().getClientToursAfterDate(date)
        keys = tripsByDate.keys.sorted(by: {(d1: Date, d2: Date) -> Bool in
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
        reloadTripData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reloadTripData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tripsByDate.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let key = keys[section]
        return (tripsByDate[key]?.count)!
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = keys[section]
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMMM dd"
        return df.string(from: key)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripByDateCell", for: indexPath) as! TripTableViewCell

        // Configure the cell...
        let key = keys[indexPath.section]
        let item = tripsByDate[key]![indexPath.row]
        
        let client = ClientTable().getClientById(item.clientId)
        let tour = TourTable().getTourById(item.tourId)
        // let guide = GuideTable().getGuideById(item.guideId)
        // let driver = DriverTable().getDriverById(item.driverId)
        
        cell.clientName!.text = client?.name
        cell.tourName!.text = tour != nil ? tour?.name : "Sin actividad definida"
        // cell.guideName!.text = guide != nil ? guide?.name : "Sin guia"
        // cell.driverName!.text = driver != nil ? driver?.name : "Sin chofer"
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "selectFilterDate" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController?.viewControllers[0] as? FilterTripDateViewController
            viewController?.date = date
        }
        
        if segue.identifier == "viewTripFullDetail" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController?.viewControllers[0] as? TripDetailViewController
            let cell = sender as? UITableViewCell
            let indexPath = tableView.indexPath(for: cell!)!
            let key = keys[indexPath.section]
            let trip = tripsByDate[key]?[indexPath.row];
            viewController!.clientTour = trip
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToTripTableViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func setFilterDate(_ segue: UIStoryboardSegue) {
        let viewController = segue.source as? FilterTripDateViewController
        date = viewController!.date! as Date
        reloadTripData()
    }

}
