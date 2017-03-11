//
//  ClientDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/10/17.
//
//

import UIKit

class ClientDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var agesTextField: UITextField!
    @IBOutlet weak var meetPlaceTextField: UITextField!
    @IBOutlet weak var totalPersonsTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    
    var client: Client?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if client != nil {
            nameTextField.text = client!.name
            countryTextField.text = client!.country
            agesTextField.text = client!.ages
            meetPlaceTextField.text = client!.meetPlace
            totalPersonsTextField.text = String(client!.totalPersons)
            commentsTextField.text = client!.comments
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveClientDetail" {
            if client == nil {
                client = Client()
            }
            
            totalPersonsTextField.text = totalPersonsTextField.text! != "" ? totalPersonsTextField.text! : "0"
            
            client?.name = nameTextField.text!
            client?.country = countryTextField.text!
            client?.ages = agesTextField.text!
            client?.meetPlace = meetPlaceTextField.text!
            client?.totalPersons = Int(totalPersonsTextField.text!)!
            client?.comments = commentsTextField.text!
        }
    }
    
}
