//
//  MonthPageViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/15/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class MonthPageViewController: UIPageViewController {
    
    var monthOverviewVC : MonthOverviewTableViewController?
    var initialMonth : MonthDayLog?
    var currMonthDayVC : UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let ndx = orderedViewControllers.index(of: currMonthDayVC!) {
            let vc = orderedViewControllers[ndx]
            if let vc = vc as? MonthViewController {
                let monthNum = Calendar.current.component(.month, from: vc.monthLog!.month)
                let formatter = DateFormatter()
                let months = formatter.monthSymbols!
                let monthName = months[monthNum-1] as String
                let year = Calendar.current.component(.year, from: vc.monthLog!.month)
                
                self.navigationItem.title = monthName + " \(year)"
            }
            setViewControllers([vc],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

    }

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
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return self.monthDayVCs()
    }()
    
    private func newMonthDayLogVC(_ monthDayLog: MonthDayLog) -> MonthViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MonthDayVC") as! MonthViewController
        vc.monthOverview = monthOverviewVC
        vc.monthLog = monthDayLog
        vc.monthPageVC = self
        return vc
    }
    
    private func monthDayVCs() -> [UIViewController] {
        var vcs : [UIViewController] = []
        
        for log in monthOverviewVC!.monthOverview!.months {
            let vc = newMonthDayLogVC(log)
            
            if self.currMonthDayVC == nil && log === initialMonth {
                print("found initial log month overview")
                self.currMonthDayVC = vc
            }
            vcs.append(vc)
        }
        
        return vcs
    }


}
