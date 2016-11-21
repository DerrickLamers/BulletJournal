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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(ciColor: .init(color: .gray))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(RapidLogViewController.insertNewCell(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // Load table
        if let tempArr = NSKeyedUnarchiver.unarchiveObject(withFile: LogEntry.ArchiveURL.path) as? [LogEntry] {
            rapidLogs = tempArr
            tableView.reloadData()
        }
    } // robert 8882183631 ext 5262598

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logEntryCell", for: indexPath) as? LogEntryCell
        
        // Configure the cell...
        let log = rapidLogs[indexPath.row]
        
        cell?.noteLable?.text = log.note
//        cell?.highTemp?.text = day.temp_h
//        cell?.lowTemp?.text = day.temp_l
//        cell?.pop?.text = day.pop
//        cell?.day?.text = day.day
        
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
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return tableView.isEditing ? .delete : .none
    }
    
    // MARK: Functionality
    
    func insertNewCell(_ sender: AnyObject) {
        let num = rapidLogs.count + 1
        let entry = LogEntry(note: "Note #\(num)")
        
        rapidLogs.append(entry)
        tableView.reloadData()
        saveLogEntries()
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
