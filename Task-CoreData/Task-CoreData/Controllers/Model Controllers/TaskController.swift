//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import CoreData

class TaskController {
    
    // MARK: - Properties
    static let shared = TaskController()
    
    var tasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD Methods
    // CREATE
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        Task(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    // READ
    func fetchTasks(){
        self.tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // UPDATE
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task ){
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteTask(task: Task) {
        guard let taskToDelete = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: taskToDelete)
        CoreDataStack.saveContext()
    }
}
