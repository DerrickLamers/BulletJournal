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
    var monthLog : MonthViewController?
    var pageVC : LogEntryPageViewController?
    var rapidLogDay : RapidLogDay?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(ciColor: .init(color: .gray))
        // add button
        monthLog?.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        // edit button
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
//        self.navigationItem.leftBarButtonItems = monthLog?.navigationItem.leftBarButtonItems
//        self.navigationItem.leftBarButtonItems = pageVC?.navigationItem.leftBarButtonItems
//        self.navigationItem.backBarButtonItem = pageVC?.navigationItem.backBarButtonItem
        //self.navigationController?.navigationBar.backItem = pageVC?.navigationController?.navigationBar.backItem
        // Load table
        if let log = rapidLogDay {
            print("able to get cell")
//            rapidLogs = log.logEntries
//            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functionality
    
    func insertNewCell(_ sender: AnyObject) {
        let ndx = rapidLogDay!.logEntries.count
        let entry : LogEntry = LogEntry(note: "Note #\(ndx+1)")
        
        rapidLogDay?.logEntries.append(entry)
        //saveLogEntries()
        tableView.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editEntrySegue" {
            let vc = segue.destination as? EntryViewController
            vc?.entryToEdit = rapidLogDay!.logEntries[(tableView.indexPathForSelectedRow?.row)!]
            vc?.entryIndex = (tableView.indexPathForSelectedRow?.row)!
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        print("segue id: \(segue.identifier)")
        print("created new entry, total: \(rapidLogDay!.logEntries.count)")
        if segue.identifier == "unwindDoneEntry" {
            tableView.reloadData()
            //saveLogEntries()
        }
        
    }
 
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logEntryCell", for: indexPath) as? LogEntryCell
        
        // Configure the cell...
        let logEntry = rapidLogDay!.logEntries[indexPath.row]
        
        cell?.noteLable?.text = logEntry.note
        cell?.logEntry = logEntry
        cell?.loadBulletImage()
        
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rapidLogDay!.logEntries.count
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
            rapidLogDay!.logEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: NSCoding
    
//    func saveLogEntries() {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(rapidLogDay!., toFile: LogEntry.ArchiveURL.path)
//        
//        if isSuccessfulSave {
//            print("Successful save!")
//        } else {
//            print("Failed save...")
//        }
//    }
//    
//    func loadLogEntries() -> [LogEntry]? {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: LogEntry.ArchiveURL.path) as? [LogEntry]
//    }
}
