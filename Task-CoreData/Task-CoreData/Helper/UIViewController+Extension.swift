//
//  UIViewController+Extension.swift
//  Task-CoreData
//
//  Created by Lee McCormick on 1/20/21.
//

import UIKit


extension UIViewController {
   func hideKeyboardWhenTappedAround() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
       view.addGestureRecognizer(tapGesture)
   }
   
   @objc func hideKeyboard() {
       view.endEditing(true)
   }
}
