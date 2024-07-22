//
//  ValidationManager.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation

struct ValidationResult{
    let error: String?
    let isSuccess: Bool
}

 class ValidationManager{
     func email(_ value:String?) -> ValidationResult{
        let email = (value ?? "").trimmingCharacters(in: .whitespaces)
        if email.isEmpty{
            return .init(error: K.emailShouldBeValid, isSuccess: false)
        }
        else{
            let reqularExpression = K.emailRegex
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: email){
                return .init(error: K.emailShouldBeValid, isSuccess: false)
            }
            else{
                return .init(error: nil, isSuccess: true)
            }
        }
    }
    
    func password(_ value: String?) -> ValidationResult {
        let password = (value ?? "").trimmingCharacters(in: .whitespaces)
        if password.isEmpty{
            return .init(error: K.passwordShouldBeNonEmpty, isSuccess: false)
        }
        else{
            let reqularExpression = K.passwordRegex
            let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
            if !predicate.evaluate(with: password){
                return .init(error: K.expectedPassword, isSuccess: false)
            }
            else{
                return .init(error: nil, isSuccess: true)
            }
        }
    }
    
}
