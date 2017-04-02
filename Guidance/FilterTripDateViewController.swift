//
//  FilterTripDateViewController.swift
//  Guidance
//
//  Created by Noel on 3/28/17.
//
//

import UIKit

class FilterTripDateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if date != nil {
            datePicker.date = date!
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
        
        if segue.identifier == "setFilterDate" {
            date = datePicker.date
        }
    }

}
