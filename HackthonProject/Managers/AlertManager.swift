//
//  AlertManager.swift
//  DaliyDo
//
//  Created by prashant on 13/08/19.
//  Copyright © 2019 prashant. All rights reserved.
//

import Foundation

import UIKit


struct AlertManager {
    
    static let shared = AlertManager()  //set as singleton class
    /**
     Default Alert
     */
    func showAlert(title:String, message:String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    /**
     Simple Action Sheet
     - Show action sheet with title and alert message and actions
     - parameter controller: source viewcontroller to show the popup
     */
    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
            print("User click Approve button")
        }))
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
            print("User click Edit button")
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        controller.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    /**
     Simple Alert with Distructive button
     - parameter controller: source viewcontroller to show the popup
     */
    func showAlertWithDistructiveButton(controller: UIViewController) {
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    /**
     Simple Alert with more than 2 buttons
     - parameter controller: source viewcontroller to show the popup
     */
    func showAlertWithThreeButton(controller: UIViewController) {
        let alert = UIAlertController(title: "Alert", message: "Alert with more than 2 buttons", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: { (_) in
            print("You've pressed default")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
            print("You've pressed cancel")
        }))
        
        alert.addAction(UIAlertAction(title: "Destructive", style: .destructive, handler: { (_) in
            print("You've pressed the destructive")
        }))
        controller.present(alert, animated: true, completion: nil)
    }

    /**
     Simple Alert with Text input
     - parameter controller: source viewcontroller to show the popup
     */
    typealias haldler = (_ string: String)->()
    
    func showAlertWithTextField(alertTitle:String, value:String, rightBtnTitle:String, leftBtnTitle:String, placeHolder:String,
        controller: UIViewController, callback: @escaping haldler){
        
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        //
        let confirmAction = UIAlertAction(title: rightBtnTitle, style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
               callback(text)
            }
        }
        let cancelAction = UIAlertAction(title: leftBtnTitle, style: .cancel) { (_) in }
        //
        alertController.addTextField { (textField) in
            textField.text        = value
            textField.placeholder = placeHolder
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTF(alertTitle:String, rightBtnTitle:String, leftBtnTitle:String, placeHolder:String,
        controller: UIViewController, callback: @escaping haldler){
        
        let alertController = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        //
        let confirmAction = UIAlertAction(title: rightBtnTitle, style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                // operations
               callback(text)
            }
        }
        alertController.addTextField { (textField) in
            textField.placeholder = placeHolder
        }
        alertController.addAction(confirmAction)
        controller.present(alertController, animated: true, completion: nil)
    }

}
