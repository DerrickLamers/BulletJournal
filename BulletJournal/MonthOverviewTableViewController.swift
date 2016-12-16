//
//  MonthOverviewTableViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/15/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class MonthOverviewTableViewController: UITableViewController {
    
    var monthOverview : MonthOverview?

    override func viewDidLoad() {
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMonth(_:)))
        self.navigationItem.title = "Overview"
        
        if let log = loadOverview() {
            print("successful month load")
            monthOverview = log
            self.tableView.reloadData()
        } else {
            let initialMonth = DateComponents(year: 2016, month: 12, day: 1)
            monthOverview = MonthOverview()
            monthOverview?.months.append(MonthDayLog(month: Calendar.current.date(from: initialMonth)!))

            // 4 months total
            addMonth(nil)
            addMonth(nil)
            addMonth(nil)
            
            for monthLog in monthOverview!.months {
                let month = monthLog.month
                let range = Calendar.current.range(of: .day, in: .month, for: month)!
                var days : [RapidLogDay] = []
                
                for day in 1...range.count {
                    let yearNum = Calendar.current.component(.year, from: month)
                    let monthNum = Calendar.current.component(.month, from: month)
                    let dayDate = Calendar.current.date(from: DateComponents(year: yearNum, month: monthNum, day: day))!
                    days.append(RapidLogDay(day: dayDate))
                }
                monthLog.days = days
            }
            saveOverview()
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMonth(_ sender: AnyObject?) {
        if let last = monthOverview?.months.last {
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: last.month)
            monthOverview?.months.append(MonthDayLog(month: nextMonth!))
            self.tableView.reloadData()
            saveOverview()
        }
    }
    
    // MARK: NSCoding
    
    func saveOverview() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(monthOverview!, toFile: MonthOverview.ArchiveURL.path)
        
        if isSuccessfulSave {
            print("Successful month overview save!")
        } else {
            print("Failed month overview save...")
        }
    }
    
    func loadOverview() -> MonthOverview? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: MonthOverview.ArchiveURL.path) as? MonthOverview
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return monthOverview!.months.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! MonthOverviewCell

        // Configure the cell...
        cell.month = monthOverview?.months[indexPath.row]
        cell.loadCell()

        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            monthOverview?.months.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveOverview()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
