//
//  DateExtension.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/19/21.
//

import Foundation

extension Date {
    
    func dateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: self)
    }
}

