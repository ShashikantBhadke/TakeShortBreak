//
//  TimeInterval+TSB.swift
//  TakeShortBreak
//
//  Created by redbytes on 4/29/19.
//  Copyright © 2019 redbytes. All rights reserved.
//

import Foundation
// MARK:- Extension for TimeInterval
extension TimeInterval{
    func inStringForm() -> String {
        let time = NSInteger(self)
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
    }
}//extension
