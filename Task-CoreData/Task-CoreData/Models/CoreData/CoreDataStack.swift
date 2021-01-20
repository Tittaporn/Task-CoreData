//
//  CoreDataStack.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import CoreData

enum CoreDataStack {
    
    // MARK: - Container
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Task_CoreData")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - Context
    static var context: NSManagedObjectContext { container.viewContext }
    
    // MARK: - SaveContext()
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}


