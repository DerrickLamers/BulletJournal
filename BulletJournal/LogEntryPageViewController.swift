//
//  LogEntryPageViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/11/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class LogEntryPageViewController: UIPageViewController {

    var monthVC : MonthViewController?
    var initialRapidLog : RapidLogDay?
    var currentRapidLogVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEntry(_:)))
        
        if let ndx = orderedViewControllers.index(of: currentRapidLogVC!) {
            let vc = orderedViewControllers[ndx]
            if let vc = vc as? RapidLogViewController {
                let formatter = DateFormatter()
                formatter.dateStyle = .full
                formatter.timeStyle = .none
                self.navigationItem.title = "\(formatter.string(from: vc.rapidLogDay!.day))"
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
    
    func addNewEntry(_ sender: AnyObject) {
        if let currVC = currentRapidLogVC as? RapidLogViewController {
            currVC.performSegue(withIdentifier: "createEntrySegue", sender: nil)
        }
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
        return self.rapidLogVCs()
    }()
    
    private func newRapidLogVC(_ rapidLog: RapidLogDay) -> RapidLogViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RapidLogsVC") as! RapidLogViewController
        vc.rapidLogDay = rapidLog
        vc.monthVC = monthVC
        vc.pageVC = self
        return vc
    }
    
    private func rapidLogVCs() -> [UIViewController] {
        var vcs : [UIViewController] = []
        
        for rapidLog in monthVC!.monthLog!.days {
            let vc = newRapidLogVC(rapidLog)

            if self.currentRapidLogVC == nil && rapidLog === initialRapidLog {
                print("found initial log")
                self.currentRapidLogVC = vc
            }
            vcs.append(vc)
        }
        
        return vcs
    }

}

