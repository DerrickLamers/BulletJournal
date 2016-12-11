//
//  RapidLogViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 11/20/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class RapidLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var rapidLogs : [LogEntry] = []
    var createdEntry : LogEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(ciColor: .init(color: .gray))
        // add button
        
        // edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Load table
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: LogEntry.ArchiveURL.path) as? [LogEntry] {
            rapidLogs = tempArr
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functionality
    
    func insertNewCell(_ sender: AnyObject) {
        let ndx = rapidLogs.count
        let entry : LogEntry = LogEntry(note: "Note #\(ndx+1)")
        
        rapidLogs.append(entry)
        saveLogEntries()
        tableView.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        print("segue id: \(segue.identifier)")
        print("created new entry, total: \(rapidLogs.count)")
        tableView.reloadData()
        saveLogEntries()
    }
 
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logEntryCell", for: indexPath) as? LogEntryCell
        
        // Configure the cell...
        let logEntry = rapidLogs[indexPath.row]
        
        cell?.noteLable?.text = logEntry.note
        cell?.logEntry = logEntry
        cell?.loadBulletImage()
        
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rapidLogs.count
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return tableView.isEditing ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rapidLogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: NSCoding
    
    func saveLogEntries() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(rapidLogs, toFile: LogEntry.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Successful save!")
        } else {
            print("Failed save...")
        }
    }
    
    func loadLogEntries() -> [LogEntry]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: LogEntry.ArchiveURL.path) as? [LogEntry]
    }
}
