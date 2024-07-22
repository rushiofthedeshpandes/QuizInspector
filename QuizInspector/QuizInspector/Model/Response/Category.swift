//
//  Category.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation

// MARK: - Category

struct Category: Codable {
    var id: Int
    var name: String
    var questions: [Question]
}
