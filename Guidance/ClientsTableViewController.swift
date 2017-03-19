//
//  ClientsTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/8/17.
//
//

import UIKit

class ClientsTableViewController: UITableViewController {
    
    var clientTable = ClientTable()
    var clients: [Client]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        clients = clientTable.getClients()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClientCell", forIndexPath: indexPath)

        let client = clients![indexPath.row] as Client
        cell.textLabel?.text = client.name
        cell.detailTextLabel?.text = "Hospedaje: \(client.meetPlace)"

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
            let client = clients![row]
            clientTable.deleteClient(client)
            clients = clientTable.getClients()
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
        if segue.identifier == "editClient" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPathForCell(cell!)!.row
            viewController!.client = clients![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToClientsTableViewController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveClientDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.sourceViewController as? ClientDetailViewController {
            if let client = viewController.client {
                if client.id == 0 {
                    // insert!
                    clientTable.addClient(client, tourList: viewController.tourList!)
                    clients = clientTable.getClients()
                    // udpate the table view
                    let index = NSIndexPath(forRow: clients!.count - 1, inSection: 0)
                    tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)
                }
                else {
                    // update!
                    clientTable.updateClient(client, tourList: viewController.tourList!)
                    clients = clientTable.getClients()
                    // refresh
                    tableView.reloadData()
                }
            }
        }
    }
    
}
