//
//  MonthDayLog.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class MonthDayLog {
    var days : [RapidLogDay] = []
    var importantEntries : [LogEntry] = []
    var month : Date
    
    init(month : Date) {
        self.month = month
    }
}
