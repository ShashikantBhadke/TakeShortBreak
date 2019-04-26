//
//  Alert.swift
//  TakeShortBreak
//
//  Created by redbytes on 4/26/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import Cocoa

class Alert {
    
    class func show(strTitle: String, strMessage: String) -> Bool {
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = strTitle
        alert.informativeText = strMessage
        alert.addButton(withTitle: "Ok")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
}//class
