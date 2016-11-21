//
//  LogEntry.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class LogEntry {
    var description : String
    var bulletType : BulletType
    var action : EntryAction
    var isImportant : Bool
    
    init(note description : String, bulletType : BulletType = .Task, action : EntryAction = .InProgress, isImportant : Bool = false) {
        self.description = description
        self.bulletType = bulletType
        self.action = action
        self.isImportant = isImportant
    }
}
