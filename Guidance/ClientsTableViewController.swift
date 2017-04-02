//
//  ClientsTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/8/17.
//
//

import UIKit

class ClientsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar?
    
    var clientTable = ClientTable()
    var clients: [Client]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchBar?.delegate = self
        clients = clientTable.getClients()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell", for: indexPath)

        let client = clients![indexPath.row] as Client
        cell.textLabel?.text = client.name
        cell.detailTextLabel?.text = "Hospedaje: \(client.meetPlace)"

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
    
    // MARK: - Search
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        clients = clientTable.getClients()
        if searchText != "" {
            clients = clients!.filter({(client: Client) -> Bool in
                return client.name.lowercased().range(of: (searchText.lowercased())) != nil
            })
        }
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "editClient" {
            let cell = sender as? UITableViewCell
            let row = tableView.indexPath(for: cell!)!.row
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientDetailViewController
            viewController!.client = clients![row]
        }
        
        if segue.identifier == "showClientTrips" {
            let cell = sender as? UITableViewCell
            let row = tableView.indexPath(for: cell!)!.row
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ClientTourTableViewController
            viewController!.clientId = clients![row].id
        }
    }
    
    // MARK: - Methods
    
    @IBAction func saveClientTourList(_ segue: UIStoryboardSegue) {
        // let viewController = segue.sourceViewController as? ClientTourTableViewController
    }
    
    @IBAction func cancelToClientsTableViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveClientDetail(_ segue: UIStoryboardSegue) {
        if let viewController = segue.source as? ClientDetailViewController {
            if let client = viewController.client {
                if client.id == 0 {
                    // insert!
                    clientTable.addClient(client)
                    // udpate the table view
                    //let index = NSIndexPath(forRow: clients!.count - 1, inSection: 0)
                    //tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)
                }
                else {
                    // update!
                    clientTable.updateClient(client)
                }
                clients = clientTable.getClients()
                // refresh
                tableView.reloadData()
            }
        }
    }
    
}
