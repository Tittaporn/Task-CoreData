//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import UIKit

// MARK: - Protocol
protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateView()
        }
    }
    
    weak var delegate: TaskCompletionDelegate?
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        if let delegate = delegate {
        delegate.taskCellButtonTapped(self)
        }
    }
    
    func updateView() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        let image = task.isComplete ? UIImage(named: "complete") : UIImage(named: "incomplete")
        completionButton.setImage(image, for: .normal)
        
        guard let date = task.dueDate else { return }
        dueDateLabel.text = date.dateToString()
    }
    

}
