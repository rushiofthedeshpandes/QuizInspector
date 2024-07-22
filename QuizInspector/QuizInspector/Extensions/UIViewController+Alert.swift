//
//  UIViewController+Alert.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.

import UIKit

extension UIViewController{
    func showAlert(_ title: String? = nil,_ message: String? = nil,_ handler: (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okey = UIAlertAction(title: K.okay, style: .default) { action in
            handler?()
        }
        alert.addAction(okey)
        
        present(alert, animated: true)
    }
}
