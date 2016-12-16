//
//  MonthOverview.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class MonthOverview: NSObject, NSCoding {
    struct MonthOverviewKey {
        static let monthsKey = "months"
    }
    var months : [MonthDayLog] = []
    
    // MARK:Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("monthOverview")
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(months, forKey: MonthOverviewKey.monthsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.months = aDecoder.decodeObject(forKey: MonthOverviewKey.monthsKey) as! [MonthDayLog]
    }
}
