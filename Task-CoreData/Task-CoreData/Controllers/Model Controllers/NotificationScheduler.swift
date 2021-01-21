//
//  NotificationScheduler.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/20/21.
//

import UserNotifications

class NotificationScheduler {
   
    func scheduleNotification(task: Task) {
        guard let dueDate = task.dueDate,
              let id = task.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        content.body = "It is time to finish \(task.name ?? "task")."
        content.sound = .default
        
        let earlierDueDate = Calendar.current.date(byAdding: .day, value: -1, to: dueDate)
        
        
        let dateComponent = Calendar.current.dateComponents([.month,.day,.hour,.minute], from: earlierDueDate ?? dueDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request. : \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification(task: Task) {
        guard let id = task.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
}
