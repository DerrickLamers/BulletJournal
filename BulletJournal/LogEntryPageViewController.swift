//
//  LogEntryPageViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/11/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

class LogEntryPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var monthLog : MonthDayLog?
    var monthVC : MonthViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewEntry(_:)))
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
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
        if let firstVC = orderedViewControllers.first {
            firstVC.performSegue(withIdentifier: "createEntrySegue", sender: nil)
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
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        self.navigationItem.title = "Index: \(previousIndex)"
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        self.navigationItem.title = "Index: \(nextIndex)"
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newRapidLogVC(self.monthLog!.days[0]),
                self.newRapidLogVC(self.monthLog!.days[1])]
    }()
    
    private func newRapidLogVC(_ rapidLog: RapidLogDay) -> UIViewController {
//        let nav = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "RapidLogsNav") as! UINavigationController
        let nav = monthVC!.parent as! UINavigationController
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RapidLogsVC") as! RapidLogViewController
        vc.rapidLogDay = rapidLog
        vc.monthLog = monthVC
        vc.pageVC = self
//        nav.viewControllers.append(vc)
        print("num vc's (before): \(nav.viewControllers.count)")
//        nav.viewControllers.append(self)
        print("num vc's (after): \(nav.viewControllers.count)")
        return vc
    }

}

