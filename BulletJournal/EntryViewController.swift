//
//  EntryViewController.swift
//  BulletJournal
//
//  Created by Jonathan Molina on 12/4/16.
//  Copyright © 2016 Jonathan Molina. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

class EntryViewController: UIViewController {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var radioButtons : [(BulletType, UIButton)] = []
    var noteType : BulletType = .Task
    var entryToEdit : LogEntry?
    var entryIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize first colors
        textView.backgroundColor = UIColor.init(hex: 0x5C6671)
        textView.layer.cornerRadius = 10
        innerView.layer.cornerRadius = 10

        createButton.tintColor! = UIColor.clear
        cancelButton.tintColor! = UIColor.clear
        
        // note type buttons
        radioButtons = [(BulletType.Task, taskButton), (BulletType.Event, eventButton), (BulletType.Information, infoButton)]
        enableButton(taskButton)
        noteType = .Task
        
        prioritySwitch.setOn(false, animated: true)
        
        // fill in fields if editing
        if let entry = entryToEdit {
            textView.text = entry.note
            prioritySwitch.setOn(entry.isImportant, animated: true)
            switch entry.bulletType {
            case .Task:
                enableButton(taskButton)
            case .Event:
                enableButton(eventButton)
            case .Information:
                enableButton(infoButton)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            // initialize final loaded colors
            self.view.backgroundColor = UIColor.black.withAlphaComponent(.init(0.2))
            self.view.isOpaque = false
            
//            self.innerView.backgroundColor = UIColor(white: .init(integerLiteral: 1), alpha: .init(1))
            self.innerView.isOpaque = true
            
//            self.createButton.tintColor! = UIColor.init(hex: 0x2680E9)
//            self.cancelButton.tintColor! = UIColor.init(hex: 0x2680E9)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func enableButton(_ b1: UIButton) {
        for (type, button) in radioButtons {
            if button == b1 {
                button.backgroundColor = UIColor.init(hex: 0xCCCEDB)
                button.setTitleColor(.white, for: .normal)
                noteType = type
            } else {
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.init(hex: 0xCCCEDB), for: .normal)
            }
        }
    }

    @IBAction func taskButtonAction(_ sender: Any) {
        enableButton(taskButton)
    }

    @IBAction func eventButtonAction(_ sender: Any) {
        enableButton(eventButton)
    }
    
    @IBAction func infoButtonAction(_ sender: Any) {
        enableButton(infoButton)
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindDoneEntry", sender: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindCancelEntry", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "unwindDoneEntry" {
            let vc = segue.destination as? RapidLogViewController
            let logEntry = LogEntry(note: textView.text, bulletType: noteType, action: .InProgress, isImportant: prioritySwitch.isOn)
            if let ndx = entryIndex {
                vc?.rapidLogDay?.logEntries[ndx] = logEntry
            }
            else {
                vc?.rapidLogDay?.logEntries.append(logEntry)
            }
        }
        entryToEdit = nil
        entryIndex = nil
    }
    

}
