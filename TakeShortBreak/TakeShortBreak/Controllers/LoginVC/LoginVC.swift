//
//  LoginVC.swift
//  TakeShortBreak
//
//  Created by redbytes on 4/26/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import Cocoa

class LoginVC: NSViewController {

    // MARK:- Outlets
    @IBOutlet weak var lblWelcome: NSTextField!
    @IBOutlet weak var tfUsername: NSTextField!
    @IBOutlet weak var btnContinue: NSButton!
    
    // MARK:- Variables
    let strWelcome = "Welcome"
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = UserDefaults.standard.value(forKey: constants.userName.rawValue) as? String{
            lblWelcome.stringValue = strWelcome + " " + str
            tfUsername.stringValue = str
            tfUsername.isHidden = true
        }
    }

    override var representedObject: Any? {
        didSet {
        }
    }

    // MARK:- Actions
    @IBAction func btnContinuePressed(_ sender: NSButton) {
        guard !tfUsername.stringValue.isEmpty else {
            _ = Alert.show(strTitle: "Warning!", strMessage: "Username is required.")
            return
        }
        lblWelcome.stringValue = strWelcome + " " + tfUsername.stringValue
        UserDefaults.standard.set(tfUsername.stringValue, forKey: constants.userName.rawValue)
        tfUsername.isHidden = true
        self.title = lblWelcome.stringValue
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            appDelegate.enableLogout()
        }
        if let homeVC = self.storyboard?.instantiateController(withIdentifier: String(describing: HomeVC.self)) as? HomeVC {
            self.view.window?.contentViewController = homeVC
        }
    }
    

}//class

