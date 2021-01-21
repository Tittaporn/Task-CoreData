//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import UIKit

// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell, isComplteted: Bool, task: Task)
}

class TaskTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesTextViewHC: NSLayoutConstraint!
    @IBOutlet weak var notesTextViegdfsgfdswHC: NSLayoutConstraint!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    var isCompleted: Bool = false
    
    weak var delegate: TaskCompletionDelegate?
    
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        guard let task = task else { return }
        isCompleted.toggle()
        delegate?.taskCellButtonTapped(self, isComplteted: isCompleted, task: task)
    }
    
    func updateView() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        let image = task.isCompleted ? UIImage(named: "complete") : UIImage(named: "incomplete")
        completionButton.setImage(image, for: .normal)
        
        dueDateLabel.text = task.dueDate?.dateToString() ?? "No due date."
        
        
        notesTextView.text = task.notes
        notesTextView.isEditable = false
        notesTextViewHC.constant = self.notesTextView.contentSize.height
    }
    

}
