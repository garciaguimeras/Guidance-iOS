//
//  ExpensesDetailViewController.swift
//  Guidance
//
//  Created by Noel on 3/11/17.
//
//

import UIKit

class ExpensesDetailViewController: UITableViewController {
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    
    var date: NSDate?
    var exp: Expenses?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        date = NSDate()
        
        if exp != nil {
            descriptionTextField.text = exp!.description
            amountTextField.text = String(exp!.amount)
            date = exp!.date
        }
        
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateTableViewCell.detailTextLabel!.text = df.stringFromDate(date!)
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
        if segue.identifier == "saveExpensesDetail" {
            if exp == nil {
                exp = Expenses()
            }
            
            amountTextField.text = amountTextField.text! != "" ? amountTextField.text! : "0"
            
            exp?.description = descriptionTextField.text!
            exp?.amount = Double(amountTextField.text!)!
            exp?.date = date
        }
        
        if segue.identifier == "setExpensesDate" {
            let navViewController = segue.destinationViewController as? UINavigationController
            let viewController = navViewController!.viewControllers[0] as? ExpensesDateViewController
            viewController!.date = date!
        }
    }
    
    // MARK: - Methods
    
    @IBAction func updateExpensesDate(segue: UIStoryboardSegue) {
        let viewController = segue.sourceViewController as? ExpensesDateViewController
        date = viewController!.date
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        dateTableViewCell.detailTextLabel!.text = df.stringFromDate(date!)
    }

}
