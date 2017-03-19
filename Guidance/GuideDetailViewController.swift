//
//  GuideDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/12/17.
//
//

import UIKit

class GuideDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var skillsTextField: UITextField!
    @IBOutlet weak var isFavoriteSwitch: UISwitch!
    
    var guide: Guide?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if guide != nil {
            nameTextField.text = guide!.name
            mobileTextField.text = guide!.mobile
            phoneTextField.text = guide!.phone
            addressTextField.text = guide!.address
            professionTextField.text = guide!.profession
            skillsTextField.text = guide!.skills
            isFavoriteSwitch.on = guide!.isFavorite
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
        if segue.identifier == "saveGuideDetail" {
            if guide == nil {
                guide = Guide()
            }
            
            guide?.name = nameTextField.text!
            guide?.mobile = mobileTextField.text!
            guide?.phone = phoneTextField.text!
            guide?.address = addressTextField.text!
            guide?.profession = professionTextField.text!
            guide?.skills = skillsTextField.text!
            guide?.isFavorite = isFavoriteSwitch.on
        }
    }

}
