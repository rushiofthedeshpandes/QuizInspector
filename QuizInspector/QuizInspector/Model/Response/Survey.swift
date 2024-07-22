//
//  Survey.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation


// MARK: - Survey
struct Survey: Codable {
    var categories: [Category]
    var id: Int
}
