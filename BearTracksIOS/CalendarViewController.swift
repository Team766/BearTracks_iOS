//
//  CalendarViewController.swift
//  BearTracks
//
//  Created by Tommy Yu on 12/24/15.
//  Copyright © 2015 Team766. All rights reserved.
//

import UIKit
import CVCalendar
import Firebase

class CalendarViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    @IBOutlet weak var toggleViewButton: UIBarButtonItem!
    @IBOutlet weak var monthName: UINavigationItem!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var selectedDay:DayView!
    var calendarRef = Firebase(url: "https://beartracks.firebaseio.com/calendarEvents")
    var events = [CalendarEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monthName.title = CVDate(date: NSDate()).globalDescription
        getEvents()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func presentedDateUpdated(date: Date) {
        self.monthName.title = date.globalDescription
        self.calendarView.contentController.refreshPresentedMonth()
    }
    
    func getEvents(){
        calendarRef.observeEventType(.ChildAdded, withBlock: {snapshot in
            let start = snapshot.value["start"] as? Double
            let end = snapshot.value["end"] as? Double
            let location = snapshot.value["location"] as? String
            let title = snapshot.value["title"] as? String
            let event = CalendarEvent(start: start!, end: end!, location: location!, title: title!)
            self.events.append(event)
            self.calendarView.contentController.refreshPresentedMonth()
        })
    }
    
    
    
    //MARK: Dot marker to show events
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let month = dayView.date.month
        
        for event in events{
            let convertDate = CVDate(date: event.startDate)
            if(month == convertDate.month){
                if(dayView.date.day == convertDate.day){
                    return true
                }
            }
        }
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let red = CGFloat(204)
        let green = CGFloat(0)
        let blue = CGFloat(0)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return [color]
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    
    //MARK: When a day is selected
    
    func didSelectDayView(dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
    }
    
    //MARK: IB Actions
    
    @IBAction func toggleView(sender: AnyObject) {
        if(calendarView.calendarMode == .MonthView){
            calendarView.changeMode(.WeekView)
            toggleViewButton.title = "Month"
        }else{
            calendarView.changeMode(.MonthView)
            toggleViewButton.title = "Week"
        }
    }
    
    @IBAction func todayToggle(sender: AnyObject) {
        self.calendarView.toggleCurrentDayView()
    }

}
