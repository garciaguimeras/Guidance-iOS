//
//  TripTableViewCell.swift
//  Guidance
//
//  Created by Noel on 3/24/17.
//
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    @IBOutlet weak var clientName: UILabel?
    @IBOutlet weak var tourName: UILabel?
    @IBOutlet weak var guideName: UILabel?
    @IBOutlet weak var driverName: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
