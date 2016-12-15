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
    var pageVC :LogEntryPageViewController?
    var monthVC : MonthViewController?
    var rapidLogDay : RapidLogDay?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(ciColor: .init(color: .gray))
        // add button
//        monthVC?.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        // edit button
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
//        self.navigationItem.leftBarButtonItems = monthLog?.navigationItem.leftBarButtonItems
//        self.navigationItem.leftBarButtonItems = pageVC?.navigationItem.leftBarButtonItems
//        self.navigationItem.backBarButtonItem = pageVC?.navigationItem.backBarButtonItem
        //self.navigationController?.navigationBar.backItem = pageVC?.navigationController?.navigationBar.backItem
        // Load table
        
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
    

    @IBAction func swipeLeft(_ sender: Any) {
        // turn to next page if there is one
        guard let ndx = pageVC?.orderedViewControllers.index(of: pageVC!.currentRapidLogVC!) else {
            return
        }

        let nextNdx = ndx + 1

        guard nextNdx <= pageVC!.orderedViewControllers.count  else {
            return
        }
        
        let vc = pageVC!.orderedViewControllers[nextNdx]
        if let vc = vc as? RapidLogViewController {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            pageVC!.navigationItem.title = "\(formatter.string(from: vc.rapidLogDay!.day))"
        }
        pageVC!.currentRapidLogVC = vc
        pageVC!.setViewControllers([vc], direction: .forward, animated: true, completion: nil)

    }

    @IBAction func swipeRight(_ sender: Any) {
        // turn to prev page if there is one
        guard let ndx = pageVC?.orderedViewControllers.index(of: pageVC!.currentRapidLogVC!) else {
            return
        }
        
        let nextNdx = ndx - 1
        
        guard nextNdx >= 0 else {
            return
        }
        
        let vc = pageVC!.orderedViewControllers[nextNdx]
        if let vc = vc as? RapidLogViewController {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            pageVC!.navigationItem.title = "\(formatter.string(from: vc.rapidLogDay!.day))"
        }
        pageVC!.currentRapidLogVC = vc
        pageVC!.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)

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
        if segue.identifier == "unwindDoneEntry" || segue.identifier == "unwindDeleteEntry" {
            tableView.reloadData()
            saveLogEntries()
        }
        
    }
 
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logEntryCell", for: indexPath) as? LogEntryCell
        
        // Configure the cell...
        let logEntry = rapidLogDay!.logEntries[indexPath.row]
        
        cell?.logEntry = logEntry
        cell?.loadCell()
        
        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rapidLogDay!.logEntries.count
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Toggles the actual editing actions appearing on a table view
        tableView.setEditing(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            rapidLogDay!.logEntries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: NSCoding
    
    func saveLogEntries() {
        monthVC!.saveMonth()
    }
    
}
