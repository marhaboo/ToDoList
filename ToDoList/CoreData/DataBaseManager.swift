//
//  DataBaseManager.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 09/11/25.
//

import Foundation
import CoreData

class DataBaseManager {
    lazy var persistentContiner: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error: \(error). userInfo: \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContiner.viewContext
    }
    
    func saveContext() {
        guard context.hasChanges else {
            return
        }
        do {
            try context.save()
            
        } catch {
            fatalError("Context error: \(error)")
        }
    }
}


class PersistentController {
    let container: NSPersistentContainer
    
    static let shared = PersistentController()
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "ToDoList")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error  = error {
                fatalError("Failed to load Core Data store: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        let context = viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                fatalError("Core Data save error: \(error.localizedDescription)")
            }
        }
        
        
    }
}


