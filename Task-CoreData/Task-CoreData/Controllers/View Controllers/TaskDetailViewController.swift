//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNoteTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround() 
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        var notes = taskNoteTextView.text
        if notes == "Enter notes here..." {
            notes = nil
        } else {
            notes = taskNoteTextView.text
        }

        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date)
            print()
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: date, tag: "other")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
    
    // MARK: - Helper Fuctions
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNoteTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
}
