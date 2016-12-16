//
//  MonthPageViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/15/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class MonthPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return self.rapidLogVCs()
    }()
    
    private func newRapidLogVC(_ rapidLog: RapidLogDay) -> RapidLogViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RapidLogsVC") as! RapidLogViewController
//        vc.rapidLogDay = rapidLog
//        vc.monthVC = monthVC
//        vc.pageVC = self
        return vc
    }
    
    private func rapidLogVCs() -> [UIViewController] {
        var vcs : [UIViewController] = []
//        
//        for rapidLog in monthVC!.monthLog!.days {
//            let vc = newRapidLogVC(rapidLog)
//            
//            if self.currentRapidLogVC == nil && rapidLog === initialRapidLog {
//                print("found initial log")
//                self.currentRapidLogVC = vc
//            }
//            vcs.append(vc)
//        }
        
        return vcs
    }


}
