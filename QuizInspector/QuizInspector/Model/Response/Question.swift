//
//  Question.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation


// MARK: - Question
struct Question: Codable {
    var answerChoices: [AnswerChoice]
    var id: Int
    var name: String
    var selectedAnswerChoiceID: Int?

    enum CodingKeys: String, CodingKey {
        case answerChoices, id, name
        case selectedAnswerChoiceID = "selectedAnswerChoiceId"
    }
}
