//
//  RapidLogDay.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class RapidLogDay {
    var logEntries : [LogEntry] = []
    var importantEntries : [LogEntry] = []
    let day : Date
    
    init(day : Date) {
        self.day = day
    }
}
