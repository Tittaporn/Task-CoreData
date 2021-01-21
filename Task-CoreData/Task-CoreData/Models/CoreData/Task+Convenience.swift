//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import CoreData

extension Task {
    @discardableResult convenience init(name: String, notes: String? = nil, dueDate: Date? = nil, isCompleted: Bool = false, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.id = id
    }
    
    
    // MARK: - CRUD Methods
    
    func add(taskWithName name: String, notes: String?, due: Date?) {

    }
    
    func update(task: Task, name: String, notes: String?, due: Date?){
        
    }
    
    func remove(task: Task) {
        
    }
    
    func fetchTasks(){
    
    }
}

