//
//  Event+CoreDataClass.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import Foundation
import CoreData


@objc(Event)
public class Event: NSManagedObject {
    
    
    class func add(event:[AnyHashable:Any])->Event?{
        if let userId = event[EVENT_ID] as? String{
            CoreDataStack.shared.DeleteUsersExcept(eventId: userId)
            if let user = CoreDataStack.shared.UpsertManagedObject(inContext: CoreDataStack.shared.viewContext, entity:EVENT_NAME_CD, key:EVENT_ID, value:userId) as? Event{
                user.update(inContext: CoreDataStack.shared.viewContext, event: event)
                return user
            }
        }else if let userId = event[EVENT_ID] as? Int{
            CoreDataStack.shared.DeleteUsersExcept(eventId: "\(userId)")
            if let user = CoreDataStack.shared.UpsertManagedObject(inContext: CoreDataStack.shared.viewContext, entity:EVENT_NAME_CD, key:EVENT_ID, value:"\(userId)") as? Event{
                user.update(inContext: CoreDataStack.shared.viewContext, event: event)
                return user
            }
        }
        return nil
    }
    
    func update(inContext context:NSManagedObjectContext, event:[AnyHashable:Any]){
        
        if let id = event[EVENT_ID] as? Int{
            self.event_id = "\(id)"
        }
        if let title = event[EVENT_TITLE] as? String{
            self.event_title = title
        }
        if let decs = event[EVENT_DECS] as? String{
            self.event_decs = decs
        }
        if let time = event[EVENT_TIME] as? String{
            self.event_time = time
        }
        
        
        CoreDataStack.shared.saveContext()
        
    }
    
    private class func GetEventData()->[Event]?{
        
        let context = CoreDataStack.shared.viewContext
        
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        
        do {
            let searchResults = try context.fetch(request)
            return searchResults
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return nil
    }
    
    class var events:[Event]?{
        get{
            return GetEventData()
        }
    }
    
    class func delete(event: Event){
       
            CoreDataStack.shared.viewContext.delete(event)
            CoreDataStack.shared.saveContext()
    }
    
    class func deleteAll(){
        if let logged = Event.events{
            for event in logged {
                CoreDataStack.shared.viewContext.delete(event)
                CoreDataStack.shared.saveContext()
            }
            
        }
    }
}
