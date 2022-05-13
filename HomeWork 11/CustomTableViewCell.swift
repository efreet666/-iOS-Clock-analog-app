//
//  CustomTableViewCell.swift
//  HomeWork 11
//
//  Created by Влад Бокин on 08.10.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var alarmSwitchLabelOutlet: UISwitch!
    @IBOutlet weak var timeLabelOutlet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
