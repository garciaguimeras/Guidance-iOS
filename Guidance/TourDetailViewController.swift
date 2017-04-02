//
//  TourDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import UIKit

class TourDetailViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var tour: Tour?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if tour != nil {
            nameTextField.text = tour!.name
            descriptionTextField.text = tour!.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveTourDetail" {
            if tour == nil {
                tour = Tour()
            }
            
            tour?.name = nameTextField.text!
            tour?.description = descriptionTextField.text!
        }
    }

}
