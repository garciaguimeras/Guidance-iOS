//
//  GuideTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import UIKit

class GuideTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar?

    var guideTable = GuideTable()
    var guides: [Guide]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchBar?.delegate = self
        guides = guideTable.getGuides()
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
        return guides!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuideCell", for: indexPath)

        let guide = guides![indexPath.row] as Guide
        cell.textLabel?.text = guide.name

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
            let guide = guides![indexPath.row]
            guideTable.deleteGuide(guide)
            guides = guideTable.getGuides()
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
        guides = guideTable.getGuides()
        if searchText != "" {
            guides = guides!.filter({(g: Guide) -> Bool in
                return g.name.lowercased().range(of: (searchText.lowercased())) != nil
            })
        }
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editGuide" {
            let navViewController = segue.destination as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? GuideDetailViewController
            let cell = sender as? UITableViewCell
            let row = tableView.indexPath(for: cell!)!.row
            viewController!.guide = guides![row]
        }
    }
    
    // MARK: - Methods
    
    @IBAction func cancelToGuidesTableViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveGuideDetail(_ segue: UIStoryboardSegue) {
        if let viewController = segue.source as? GuideDetailViewController {
            if let guide = viewController.guide {
                if guide.id == 0 {
                    // insert!
                    guideTable.addGuide(guide)
                    // udpate the table view
                    //let index = NSIndexPath(forRow: guides!.count - 1, inSection: 0)
                    //tableView.insertRowsAtIndexPaths([index], withRowAnimation: .Automatic)
                }
                else {
                    // update!
                    guideTable.updateGuide(guide)
                }
                guides = guideTable.getGuides()
                // refresh
                tableView.reloadData()
            }
        }
    }

}
