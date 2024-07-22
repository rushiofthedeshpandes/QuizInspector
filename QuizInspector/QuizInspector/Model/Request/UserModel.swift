//
//  GenericUserModel.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation

struct UserModel: Decodable, Encodable{
    var email: String?
    var password: String?
}
