//
//  DiaryNote.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import UIKit
import CoreData

class DiaryNote: NSManagedObject {
    
    func shortDateFormat() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        //        dateFormatter.doesRelativeDateFormatting = true
        
        
        
        
        let formattedDateString = dateFormatter.stringFromDate(creationDate!)
        return formattedDateString
    }
    
    func longDateFormat() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        //        dateFormatter.doesRelativeDateFormatting = true
        
        let formattedDateString = dateFormatter.stringFromDate(creationDate!)
        return formattedDateString
    }
    
    func titleDateFormat() -> String {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        //        dateFormatter.doesRelativeDateFormatting = true
        
        let formattedDateString = dateFormatter.stringFromDate(creationDate!)
        return formattedDateString
    }
}
