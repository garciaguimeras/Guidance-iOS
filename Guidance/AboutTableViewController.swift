//
//  AboutTableViewController.swift
//  Guidance
//
//  Created by Noel on 3/30/17.
//
//

import UIKit
import UserNotifications

class AboutTableViewController: UITableViewController {
    
    @IBOutlet weak var activationDateLabel: UILabel?
    @IBOutlet weak var databaseVersion: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let appInfo = GuidanceTable().getAppInfo()!
        let date = appInfo.activationDate
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        
        activationDateLabel!.text = "Activado el dia \(df.string(from: date!))"
        databaseVersion!.text = "Version de la base de datos: \(appInfo.databaseVersion)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
