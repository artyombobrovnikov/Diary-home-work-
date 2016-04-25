//
//  DiaryNoteCore.swift
//  Diary (home work)
//
//  Created by Admin on 21.04.16.
//  Copyright © 2016 Bobrovnikov. All rights reserved.
//

import Foundation
import CoreData

extension DiaryNote {
    
    @NSManaged var creationDate: NSDate?
    @NSManaged var text: String?
    @NSManaged var title: String?
    @NSManaged var weatherState: NSNumber?
    
}
