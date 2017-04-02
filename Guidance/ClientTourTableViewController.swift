//
//  ClientTourTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/15/17.
//
//

import UIKit

class ClientTourTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar?
    
    var table = ClientTourTable()
    var list: [ClientTour]?
    
    var clientId: Int64?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        searchBar?.delegate = self
        list = table.getClientToursByClient(clientId!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)

        // Configure the cell...
        let ct = list![indexPath.row] as ClientTour
        var tour: Tour? = nil
        if ct.tourId != 0 {
            let tourTable = TourTable()
            tour = tourTable.getTourById(ct.tourId)
        }
        cell.textLabel?.text = tour != nil ? tour?.name : "Sin actividad definida"
        
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = String(df.string(from: ct.date! as Date))

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
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
    
    // MARK: - Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        list = table.getClientToursByClient(clientId!)
        if searchText != "" {
            list = list!.filter({(ct: ClientTour) -> Bool in
                let tour = TourTable().getTourById(ct.tourId)
                return tour?.name.lowercased().range(of: (searchText.lowercased())) != nil
            })
        }
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editTrip" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPath(for: cell!)!.row
            viewController!.ct = list![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToClientTourTableViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveClientTourDetail(_ segue: UIStoryboardSegue) {
        if let viewController = segue.source as? ClientTourDetailViewController {
            if let ct = viewController.ct {
                ct.clientId = clientId!
                if ct.id == 0 {
                    // insert!
                    table.addClientTour(ct)
                    // udpate the table view
                    //let index = NSIndexPath(forRow: list!.count - 1, inSection: 0)
                    //tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)                
                }
                else {
                    // update!
                    table.updateClientTour(ct)
                }
                list = table.getClientToursByClient(clientId!)
                // refresh
                tableView.reloadData()
            }
        }
    }

}
