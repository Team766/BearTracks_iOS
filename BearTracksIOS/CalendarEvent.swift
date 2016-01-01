//
//  CalendarEvent.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/25/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit

class CalendarEvent {
    
    var startDate: NSDate
    var endDate: NSDate
    var startTime: Double
    var endTime: Double
    var location: String
    var title: String
    
    init(start: Double, end: Double, location: String, title: String){
        self.startTime = start
        self.endTime = end
        self.startDate = NSDate(timeIntervalSince1970: start/1000)
        self.endDate = NSDate(timeIntervalSince1970: end/1000)
        self.location = location
        self.title = title
    }
    
}
