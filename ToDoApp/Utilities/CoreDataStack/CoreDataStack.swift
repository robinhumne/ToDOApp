//
//  CoreDataStack.swift
//  ToDoApp
//
//  Created by pikateck on 20/12/21.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    /// Shared singletone object of HttpClient
    static let shared : CoreDataStack = {
        let instance = CoreDataStack()
        return instance
    }()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ToDoApp")
        print(container.persistentStoreDescriptions.first?.url as Any)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Core Data View Context
    
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    
    func UpsertManagedObject(inContext context:NSManagedObjectContext, entity:String,key:String, value:String)->NSManagedObject{
        guard let object = GetObject(fromContext: context, entity:entity,key: key, value: value) else{
            return CreateObject(inContext: context, entity: entity)
        }
        return object
    }
    
    func CreateObject(inContext context:NSManagedObjectContext, entity:String)->NSManagedObject{
        return NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
    }
    
    func GetObject(fromContext context:NSManagedObjectContext, entity:String, key:String,value:String)->NSManagedObject?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format: "\(key) == \(value)")
        
        do {
            let searchResults = try context.fetch(request)
            return searchResults.first as! NSManagedObject?
            
        } catch {
            print("Error with request: \(error)")
        }
        
        return nil
    }
    
    func TruncateEntity(entityName:String){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.includesPropertyValues = false
        
            do {
                let searchResults = try CoreDataStack.shared.viewContext.fetch(fetch)
                for obj in searchResults {
                    CoreDataStack.shared.viewContext.delete(obj as! NSManagedObject)
                }
                CoreDataStack.shared.saveContext()
            } catch let error {print("Error with request: \(error)")}
            
        
    }
    
    func DeleteUsersExcept(eventId:String){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: EVENT_NAME_CD)
        fetch.includesPropertyValues = false
        
            do {
                let searchResults = try CoreDataStack.shared.viewContext.fetch(fetch)
                for obj in searchResults {
                    if let event = obj as? Event, let event_id = event.event_id {
                        if eventId != event_id {
                            CoreDataStack.shared.viewContext.delete(obj as! NSManagedObject)
                        }
                    }
                }
                CoreDataStack.shared.saveContext()
                
            } catch let error {print("Error with request: \(error)")}
            
        
    }
}
