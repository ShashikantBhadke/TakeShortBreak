//
//  AppDelegate.swift
//  TakeShortBreak
//
//  Created by redbytes on 4/26/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: Outlets
    @IBOutlet weak var btnLogout: NSMenuItem!

    // MARK:- Default Methods
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if UserDefaults.standard.value(forKey: constants.userName.rawValue) == nil {
            enableLogout(false)
        }
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
    // MARK:- Custom Action Methods
    @IBAction func btnMenuLogoutPressed(_ sender: NSMenuItem) {
        guard UserDefaults.standard.value(forKey: constants.userName.rawValue) != nil else {
            debugPrint("It's bug. I can logout without login")
            return
        }
        if let loginVC = mainStoryboard.instantiateController(withIdentifier: String(describing: LoginVC.self)) as? LoginVC {
            UserDefaults.standard.removeObject(forKey: constants.userName.rawValue)
            NSApplication.shared.mainWindow?.contentViewController = loginVC
            enableLogout(false)
        }
    }
    // MARK:- Custom Methods
    func enableLogout(_ isTrue: Bool = true) {
        btnLogout.isHidden = !isTrue
    }
}//class

