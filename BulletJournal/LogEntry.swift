//
//  LogEntry.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import Foundation

class LogEntry: NSObject, NSCoding {
    struct LogEntryKey {
        static let descKey = "discription"
        static let bulletTypeKey = "bulletType"
        static let actionKey = "action"
        static let isImportantKey = "isImportant"
    }
    
    // MARK:Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("logEntries")
    
    var note : String
    var bulletType : BulletType
    var action : EntryAction
    var isImportant : Bool
    
    init(note : String, bulletType : BulletType = .Task, action : EntryAction = .InProgress, isImportant : Bool = false) {
        self.note = note
        self.bulletType = bulletType
        self.action = action
        self.isImportant = isImportant
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(note, forKey: LogEntryKey.descKey)
        aCoder.encode(bulletType.rawValue, forKey: LogEntryKey.bulletTypeKey)
        aCoder.encode(action.rawValue, forKey: LogEntryKey.actionKey)
        aCoder.encode(isImportant, forKey: LogEntryKey.isImportantKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let note = aDecoder.decodeObject(forKey: LogEntryKey.descKey) as! String
        let bulletType = BulletType(rawValue: aDecoder.decodeObject(forKey: LogEntryKey.bulletTypeKey) as! String)
        let action = EntryAction(rawValue: aDecoder.decodeObject(forKey: LogEntryKey.actionKey) as! String)
        let isImportant = aDecoder.decodeBool(forKey: LogEntryKey.isImportantKey)

        self.init(note: note, bulletType: bulletType!, action: action!, isImportant: isImportant)
    }
}
