//
//  Event+CoreDataProperties.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: EVENT_NAME_CD)
    }

    @NSManaged public var event_id: String?
    @NSManaged public var event_title: String?
    @NSManaged public var event_decs: String?
    @NSManaged public var event_time: String?
    

}
