//
//  DriverDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import UIKit

class DriverDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var carTypeTextField: UITextField!
    @IBOutlet weak var rateSegmentedControl: UISegmentedControl!
    
    var driver: Driver?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if driver != nil {
            nameTextField.text = driver!.name
            mobileTextField.text = driver!.mobile
            phoneTextField.text = driver!.phone
            addressTextField.text = driver!.address
            carTypeTextField.text = driver!.carType
            rateSegmentedControl.selectedSegmentIndex = driver!.rate
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
        if segue.identifier == "saveDriverDetail" {
            if driver == nil {
                driver = Driver()
            }
            
            driver!.name = nameTextField.text!
            driver!.mobile = mobileTextField.text!
            driver!.phone = phoneTextField.text!
            driver!.address = addressTextField.text!
            driver!.carType = carTypeTextField.text!
            driver!.rate = rateSegmentedControl.selectedSegmentIndex
        }
    }

}
