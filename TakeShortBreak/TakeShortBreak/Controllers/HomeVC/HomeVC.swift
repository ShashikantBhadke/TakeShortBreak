//
//  HomeVC.swift
//  TakeShortBreak
//
//  Created by redbytes on 4/26/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import Cocoa

class HomeVC: NSViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var lblUsername: NSTextField!
    @IBOutlet weak var lblStartTime: NSTextField!
    @IBOutlet weak var lblLastTime: NSTextField!
    @IBOutlet weak var lblDuration: NSTextField!
    @IBOutlet weak var btnStart: NSButton!
    
    // MARK:- Variables
    var startDate = Date()
    var isStart = false
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.layer?.backgroundColor = NSColor.white.cgColor
        if let str = UserDefaults.standard.value(forKey: constants.userName.rawValue) as? String {
            lblUsername.stringValue = str
            lblStartTime.stringValue = ""
            lblLastTime.stringValue = ""
            lblDuration.stringValue = "0"
        }
    }
    
    override var representedObject: Any? {
        didSet {
        }
    }
    
    // MARK:- Actions
    @IBAction func btnStartPressed(_ sender: NSButton) {
        
        if !self.isStart {
            sender.title = "Stop"
            self.startDate = Date()
            self.lblStartTime.stringValue = String(describing: self.startDate.self)
            self.createLocalNotification()
        } else {
            sender.title = "Start"
            self.createLocalNotification(isClear: true)
        }
        self.isStart.toggle()
        
    }    
    // MARK:- Custom Methods
    private func createLocalNotification(isClear: Bool = false) {//(withTitle strTitle: String, body: String, onDate: Date) {
        
        let timeDifference = 2
        
        let notification = NSUserNotification()
        let notifiCenter = NSUserNotificationCenter.default
        let shotDate = Date(timeIntervalSinceNow: TimeInterval(timeDifference))
        var repeatCount = DateComponents()
        
        repeatCount.day = 0
        repeatCount.minute = timeDifference
        notifiCenter.delegate = self
        notification.hasReplyButton = false
        notification.hasActionButton = true
        notification.actionButtonTitle = "Close"
        notification.otherButtonTitle = "Show"
        notification.identifier = "takeShortBreak01"
        notification.title = "Take Short Break"
        notification.subtitle = "It's been \(timeDifference) min you haven't taken any break."
        notification.soundName =  NSUserNotificationDefaultSoundName
        notification.deliveryDate = shotDate
        notification.deliveryRepeatInterval = repeatCount
        notifiCenter.removeDeliveredNotification(notification)
        notifiCenter.removeScheduledNotification(notification)
        notifiCenter.removeAllDeliveredNotifications()
        guard !isClear else { return }
        notifiCenter.deliver(notification)
        notifiCenter.perform(Selector(("removeNotifiation")), with: notification, afterDelay: TimeInterval(timeDifference + 10))
    }
    
    @objc func removeNotifiation(_ notification: NSUserNotification) {
        print("auto remove called")
        let notifiCenter = NSUserNotificationCenter.default
        notifiCenter.removeDeliveredNotification(notification)
        notifiCenter.removeScheduledNotification(notification)
        notifiCenter.removeAllDeliveredNotifications()
    }
    
}//class
// MARK:- Extension for NSUserNotificationCenterDelegate
extension HomeVC: NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        debugPrint("didDeliver called")
        let timeDiff = Date().timeIntervalSince(startDate)
        DispatchQueue.main.async {
            self.lblLastTime.stringValue = String(describing: Date().self)
            self.lblDuration.stringValue = timeDiff.inStringForm()
        }
    }

    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        debugPrint("didActivate called")
        guard let res = notification.response else { return }
        switch notification.activationType {
        case .replied:
            print("User replied: \(res.string)")
        case .additionalActionClicked:
            print("User additional action clicked: \(res.string)")
        default:
            break
        }
        
        
    }
}//extension
