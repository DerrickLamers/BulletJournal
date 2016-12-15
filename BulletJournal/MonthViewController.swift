//
//  MonthViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/10/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var monthLog : MonthDayLog?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load table
        if let log = loadMonth() {
            print("loaded month table")
            monthLog = log
            tableView.reloadData()
        } else {
            let month = Calendar.current.date(from: DateComponents(year: 2016, month:12))!
            let range = Calendar.current.range(of: .day, in: .month, for: month)!
            var days : [RapidLogDay] = []
            
            for day in 1...range.count {
                let yearNum = Calendar.current.component(.year, from: month)
                let monthNum = Calendar.current.component(.month, from: month)
                let dayDate = Calendar.current.date(from: DateComponents(year: yearNum, month: monthNum, day: day))!
                days.append(RapidLogDay(day: dayDate))
            }
            monthLog = MonthDayLog(month: month)
            monthLog?.days = days
            saveMonth()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pageEntriesSegue" {
            let vc = segue.destination as! LogEntryPageViewController
            vc.monthVC = self
            vc.initialRapidLog = monthLog?.days[(tableView.indexPathForSelectedRow?.row)!]
//            self.parent!.navigationItem.backBarButtonItem!.title = "December"
//            let backItem = UIBarButtonItem()
//            backItem.title = "December"
//            self.parent!.navigationItem.backBarButtonItem = backItem
        }
    }
 
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rapidLogDayCell", for: indexPath) as? RapidLogDayCell
        
        // Configure the cell...
        let rapidLog = monthLog?.days[indexPath.row]
        
        cell?.rapidLogDay = rapidLog
        cell?.loadCell()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (monthLog?.days.count)!
    }
    
    // MARK: NSCoding
    
    func saveMonth() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(monthLog!, toFile: MonthDayLog.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Successful save!")
        } else {
            print("Failed save...")
        }
    }
    
    func loadMonth() -> MonthDayLog? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MonthDayLog.ArchiveURL.path) as? MonthDayLog
    }
}
