//
//  MonthDayLog.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class MonthDayLog: NSObject, NSCoding {
    struct MonthDayLogKey {
        static let daysKey = "days"
        static let importantLogsKey = "importantEntries"
        static let monthKey = "month"
    }
    // MARK:Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("monthEntry")

    var days : [RapidLogDay] = []
    var importantEntries : [LogEntry] = []
    var month : Date

    init(month : Date) {
        self.month = month
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(days, forKey: MonthDayLogKey.daysKey)
        aCoder.encode(importantEntries, forKey: MonthDayLogKey.importantLogsKey)
        aCoder.encode(month, forKey: MonthDayLogKey.monthKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(month: aDecoder.decodeObject(forKey: MonthDayLogKey.monthKey) as! Date)
        self.days = aDecoder.decodeObject(forKey: MonthDayLogKey.daysKey) as! [RapidLogDay]
        self.importantEntries = aDecoder.decodeObject(forKey: MonthDayLogKey.importantLogsKey) as! [LogEntry]
    }
}
