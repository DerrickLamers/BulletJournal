//
//  RapidLogDayCell.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/10/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class RapidLogDayCell: UITableViewCell {

    @IBOutlet weak var dayNumLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    var rapidLogDay : RapidLogDay?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dayNumLabel.text = ""
        weekdayLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell() {
        if let day = rapidLogDay {
            dayNumLabel.text = "\(Calendar.current.component(.day, from: day.day))"
            let weekday = Calendar.current.component(.weekday, from: day.day)
            let weekdayName = DateFormatter().weekdaySymbols[weekday-1]
            let index = weekdayName.index(weekdayName.startIndex, offsetBy: 1)
            weekdayLabel.text = weekdayName.substring(to: index)
        }
    }

}
