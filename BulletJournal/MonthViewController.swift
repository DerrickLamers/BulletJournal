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
    var monthPageVC : MonthPageViewController?
    var monthOverview : MonthOverviewTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        // turn to next page if there is one
        guard let ndx = monthPageVC?.orderedViewControllers.index(of: monthPageVC!.currMonthDayVC!) else {
            return
        }
        
        let nextNdx = ndx + 1
        
        guard nextNdx < monthPageVC!.orderedViewControllers.count  else {
            return
        }
        
        let vc = monthPageVC!.orderedViewControllers[nextNdx]
        if let vc = vc as? MonthViewController {
            let monthNum = Calendar.current.component(.month, from: vc.monthLog!.month)
            let formatter = DateFormatter()
            let months = formatter.monthSymbols!
            let monthName = months[monthNum-1] as String
            let year = Calendar.current.component(.year, from: vc.monthLog!.month)
            
            monthPageVC!.navigationItem.title = monthName + " \(year)"
        }
        monthPageVC!.currMonthDayVC = vc
        monthPageVC!.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        // turn to next page if there is one
        guard let ndx = monthPageVC?.orderedViewControllers.index(of: monthPageVC!.currMonthDayVC!) else {
            return
        }
        
        let nextNdx = ndx - 1
        
        guard nextNdx >= 0  else {
            return
        }
        
        let vc = monthPageVC!.orderedViewControllers[nextNdx]
        if let vc = vc as? MonthViewController {
            let monthNum = Calendar.current.component(.month, from: vc.monthLog!.month)
            let formatter = DateFormatter()
            let months = formatter.monthSymbols!
            let monthName = months[monthNum-1] as String
            let year = Calendar.current.component(.year, from: vc.monthLog!.month)
            
            monthPageVC!.navigationItem.title = monthName + " \(year)"
        }
        monthPageVC!.currMonthDayVC = vc
        monthPageVC!.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
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
        monthOverview?.saveOverview()
    }
}
