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
    let notificationScheduler = NotificationScheduler()
    
    //var tasks: [Task] = []
    // S.O.T.
    var sections: [[Task]] {[notCompletedTasks, completedTasks]}
    var notCompletedTasks: [Task] = []
    var completedTasks: [Task] = []
    
//    var taskTagToFeth: String {
//        
//        let task: Task
//        switch task.tag {
//        case "home":
//            return "home"
//        case "work":
//            return "work"
//        case "school":
//            return "school"
//        case "grocery":
//            return "grocery"
//        default:
//            return "other"
//        }
//    }()
    
    // [:[]]
    
    
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    //
    private lazy var fetchRequestForEachTag: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        
        //request.predicate = NSPredicate(value: true)
        request.predicate = NSPredicate(format: "name == %@", "school")
        return request
    }()
    
    
    
    // MARK: - CRUD Methods
    // CREATE
    func createTaskWith(name: String, notes: String?, dueDate: Date?, tag: String?) {
        let task = Task(name: name, notes: notes, dueDate: dueDate, tag: tag)
        notCompletedTasks.append(task)
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(task: task)
    }
    
    // READ
    func fetchTasks(){
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        completedTasks = tasks.filter{ $0.isCompleted == true}
        notCompletedTasks = tasks.filter{ $0.isCompleted == false}
    }
    
    func fetchTasksEachTag() {
        
    }
    
    // UPDATE
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
        notificationScheduler.cancelNotification(task: task)
        notificationScheduler.scheduleNotification(task: task)
    }
    
    func toggleIsComplete(task: Task ){
        task.isCompleted.toggle()
        CoreDataStack.saveContext()
    }
    
    func updateTaskCompletionStatus(with task: Task) {
        if task.isCompleted {
            if let index = notCompletedTasks.firstIndex(of: task) {
                notCompletedTasks.remove(at: index)
                completedTasks.append(task)
            }
        } else {
            if let index = completedTasks.firstIndex(of: task) {
                completedTasks.remove(at: index)
                notCompletedTasks.append(task)
            }
        }
        
        CoreDataStack.saveContext()
    }
    
    // DELETE
    func deleteTask(with task: Task) {
        if task.isCompleted {
            if let index = completedTasks.firstIndex(of: task) {
                completedTasks.remove(at: index)
            }
        } else {
            if let index = notCompletedTasks.firstIndex(of: task) {
                notCompletedTasks.remove(at: index)
            }
        }
        CoreDataStack.context.delete(task)
        notificationScheduler.cancelNotification(task: task)
        CoreDataStack.saveContext()
    }
    
    func lookForTaskTag(task: Task) -> String {
//        if task.tag == "school" {
//            return "school"
//        } else if
        switch task.tag {
        case "home":
            return "home"
        case "work":
            return "work"
        case "school":
            return "school"
        case "grocery":
            return "grocery"
        default:
            return "other"
        }
    }
}

