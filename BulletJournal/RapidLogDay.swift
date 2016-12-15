//
//  RapidLogDay.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class RapidLogDay: NSObject, NSCoding {
    struct RapidLogDayKey {
        static let logsKey = "logEntries"
        static let importantLogsKey = "importantEntries"
        static let dayKey = "day"
    }
    var logEntries : [LogEntry] = []
    let day : Date
    
    init(day : Date) {
        self.day = day
    }
    
    func getImportantEntries() -> [LogEntry] {
        var importantEntries : [LogEntry] = []
        
        for log in logEntries {
            if log.isImportant {
                importantEntries.append(log)
            }
        }
        return importantEntries
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(logEntries, forKey: RapidLogDayKey.logsKey)
        aCoder.encode(day, forKey: RapidLogDayKey.dayKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(day: aDecoder.decodeObject(forKey: RapidLogDayKey.dayKey) as! Date)
        self.logEntries = aDecoder.decodeObject(forKey: RapidLogDayKey.logsKey) as! [LogEntry]
    }
}
