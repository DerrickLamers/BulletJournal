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

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var taskButton: UIButton!
    @IBOutlet weak var eventButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var prioritySwitch: UISwitch!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var radioButtons : [(BulletType, UIButton)] = []
    var noteType : BulletType = .Task

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField?.delegate = self
        innerView.layer.cornerRadius = 10

        createButton.tintColor! = UIColor.clear
        cancelButton.tintColor! = UIColor.clear
        
        // note type buttons
        radioButtons = [(BulletType.Task, taskButton), (BulletType.Event, eventButton), (BulletType.Information, infoButton)]
        enableButton(taskButton)
        noteType = .Task
        
        prioritySwitch.setOn(false, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25) {
            self.view.backgroundColor = UIColor(white: .init(integerLiteral: 0), alpha: .init(0.2))
            self.view.isOpaque = false
            self.innerView.backgroundColor = UIColor(white: .init(integerLiteral: 1), alpha: .init(1))
            self.innerView.isOpaque = true
            self.createButton.tintColor! = UIColor.init(hex: 0x2680E9)
            self.cancelButton.tintColor! = UIColor.init(hex: 0x2680E9)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
        //TODO add new cell to table
        self.performSegue(withIdentifier: "unwindFromCreateEntry", sender: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindFromCreateEntry", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
