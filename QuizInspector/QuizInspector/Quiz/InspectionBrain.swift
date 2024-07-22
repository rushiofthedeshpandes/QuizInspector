//
//  InspectionBrain.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import Foundation

class InspectionBrain{
    
    var questions : [Question] = []
    var questionNumber = 0
    var score = 0.0
    var answerChoices : [AnswerChoice] = []
    private var updatedQuestion : Question?
    
    init(_ questions: [Question], questionNumber: Int = 0, score: Double = 0.0) {
        self.questions = questions
        self.questionNumber = questionNumber
        self.score = score
    }
    
    func getCurrentQuestion() -> Question?{
        if let newQuestion = updatedQuestion{
            return newQuestion
        }
        return nil
    }
    
    func getQuestionText() -> String{
        guard questions.count > 0 else {return ""}
        return questions[questionNumber].name
    }
    
    func getAnswerChoices() -> [AnswerChoice]{
        return questions[questionNumber].answerChoices
    }

    func getProgress() -> Float{
        return Float(questionNumber + 1) / Float(questions.count)
    }

    func checkAnswer(_ userChoice: AnswerChoice?){
        if let selectedChoice = userChoice{
            let newQuestion = Question(answerChoices: questions[questionNumber].answerChoices,
                                       id: questions[questionNumber].id,
                                       name: questions[questionNumber].name,
                                       selectedAnswerChoiceID: selectedChoice.id)
            updatedQuestion = newQuestion
            score += selectedChoice.score
        }
    }
    
    func isNextQuestionAvailable()-> Bool{
        if questionNumber + 1 < questions.count{
            return true
        }
        else{
            return false
        }
    }

    func nextQuestion(){
        if questionNumber + 1 < questions.count{
            questionNumber += 1
        }
//        else{
//            questionNumber = 0
//            score = 0
//        }
    }

    func getScore() -> Double{
        return score
    }

}
