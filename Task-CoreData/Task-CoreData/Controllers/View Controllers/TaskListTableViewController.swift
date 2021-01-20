//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.shared.fetchTasks()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }

        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.task = task
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
                
             CoreDataStack.container.viewContext.delete(taskToDelete)
            TaskController.shared.tasks.remove(at: indexPath.row)
            CoreDataStack.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
             
         }
     }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? TaskDetailViewController else { return }
            let task = TaskController.shared.tasks[indexPath.row]
            destinationVC.task = task
        }
    }
}

// MARK: - Extension TaskCompletionDelegate

extension TaskListTableViewController: TaskCompletionDelegate {
  
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        
        //  guard to make sure we have a task
        guard let taskToToggle = sender.task else { return }
        
        // call toggleIsComplete function on TaskController.
        TaskController.shared.toggleIsComplete(task: taskToToggle)
        
        // re-call your updateViews() function on the sender.
        sender.updateView()
    }
}
