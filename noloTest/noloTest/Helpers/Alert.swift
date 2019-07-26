//
//  Alert.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView

class Alert {
    
    static func handleError(_ err: Error) {
        switch err {
        case APIError.noData:
            Alert.showOKAlertOnWindow(message: "No data received, try relaunching", title: "Error")
            break
        case APIError.parseError(let errorString):
            Alert.showOKAlertOnWindow(message: errorString, title: "Error")
            break
        default:
            Alert.showOKAlertOnWindow(message: "Please try again", title: "Error")
            break
            
        }
        
    }
    
    static func showOKSCAlert(message: String, title: String) {
        let alertView = SCLAlertView()
        
        alertView.showSuccess(title, subTitle: message)
    }
    
    static func showOKAlert(message: String, title: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.show(alert, sender: self)
    }
    
    static func showOKAlertOnWindow(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithActions(message: String, title: String, actions: [UIAlertAction], vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
