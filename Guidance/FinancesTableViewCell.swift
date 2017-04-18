//
//  FinancesTableViewCell.swift
//  Guidance
//
//  Created by Noel on 4/17/17.
//
//

import UIKit

class FinancesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tripProfitsLabel: UILabel?
    @IBOutlet weak var guideCommissionsLabel: UILabel?
    @IBOutlet weak var driverCommissionsLabel: UILabel?
    @IBOutlet weak var otherExpensesLabel: UILabel?
    @IBOutlet weak var totalLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
