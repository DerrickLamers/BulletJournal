//
//  MonthOverviewCell.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/15/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class MonthOverviewCell: UITableViewCell {

    @IBOutlet weak var monthYearLabel: UILabel!
    var month : MonthDayLog?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        monthYearLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell() {
        if let log = month {
            let monthNum = Calendar.current.component(.month, from: log.month)
            let formatter = DateFormatter()
            let months = formatter.monthSymbols!
            let monthName = months[monthNum-1] as String
            let year = Calendar.current.component(.year, from: log.month)
            
            monthYearLabel.text = monthName + " \(year)"
        }
    }

}
