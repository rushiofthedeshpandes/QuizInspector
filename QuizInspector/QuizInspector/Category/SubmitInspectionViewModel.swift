//
//  SubmitInspectionViewModel.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 21/07/24.
//

import Foundation
import Combine

class SubmitInspectionViewModel{
    private let endpoint: Endpoint?
    
    var inspectionSubject = PassthroughSubject<Int, Error>()
    private var subscribers = Set<AnyCancellable>()
    
    init(endpoint: Endpoint?) {
        self.endpoint = endpoint
    }
    
    func performAction(_ root : Root){
        guard let endpoint = endpoint else{
            self.inspectionSubject.send(completion: .failure(APIError.apiError(reason: K.invalidInput)))
            return
        }
        let url = URL(string: endpoint.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = K.HTTP_POST
        let inspectionJson = getInspection(root)
        request.setValue(K.application_json, forHTTPHeaderField: K.content_type)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: inspectionJson,
                                                         options: [])
        else {
            self.inspectionSubject.send(completion: .failure(APIError.apiError(reason: K.invalidInput)))
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.inspectionSubject.send(completion: .failure(APIError.apiError(reason: K.failedToRegisterUser)))
                return
            }
            self.inspectionSubject.send(httpResponse.statusCode)
        }.resume()
    }
}


//MARK: -DATA PARSING HELPER METHODS

extension SubmitInspectionViewModel {
   
    private func getInspection(_ root: Root) -> [String : Any]{
        let inspection = root.inspection
        let area = inspection.area
        let inspectionType = inspection.inspectionType
        let survey = inspection.survey
        
        let surveyValues = [K.REQUEST_ID : survey.id,
                            K.REQUEST_CATEGORIES : getUpdatedCategories(for: survey)] as [String : Any]
        
        let inspectionTypeValues = [K.REQUEST_ACCESS: inspectionType.access,
                                    K.REQUEST_ID: inspectionType.id,
                                    K.REQUEST_NAME: inspectionType.name] as [String : Any]
        let areaValues = [K.REQUEST_ID : area.id,
                          K.REQUEST_NAME : area.name] as [String : Any]
        
        let inspectionValues = [K.REQUEST_AREA: areaValues,
                                K.REQUEST_ID: root.inspection.id,
                                K.REQUEST_INSPECTIONTYPE : inspectionTypeValues,
                                K.REQUEST_SURVEY: surveyValues] as [String : Any]
        return [K.REQUEST_INSPECTION : inspectionValues]
    }
    
    private func getUpdatedCategories(for survey: Survey)->[[String:Any]]{
        var updatedCategories : [[String:Any]] = [[:]]
        for category in survey.categories{
            let newCategory = [K.REQUEST_ID: category.id,
                               K.REQUEST_NAME : category.name,
                               K.REQUEST_QUESTIONS: getUpdatedQuestions(for: category)] as [String : Any]
            updatedCategories.append(newCategory)
        }
        return updatedCategories
    }
    
    private func getUpdatedQuestions(for category: Category)->[[String:Any]]{
        var updatedQuestions : [[String:Any]] = [[:]]
        for question in category.questions{
            let selectedAnswer = 0
            if let selectedAnswer = question.selectedAnswerChoiceID{
                let newQuestion = [K.REQUEST_ID : question.id,
                                   K.REQUEST_NAME : question.name,
                                   K.REQUEST_ANSWERCHOICES : getUpdatedAnswerChoices(for: question),
                                   K.REQUEST_SELECTEDANSERCHOICEID : question.selectedAnswerChoiceID!] as [String : Any]
                updatedQuestions.append(newQuestion)
            }else{
                let newQuestion = [K.REQUEST_ID : question.id,
                                   K.REQUEST_NAME : question.name,
                                   K.REQUEST_ANSWERCHOICES : getUpdatedAnswerChoices(for: question)] as [String : Any]
                updatedQuestions.append(newQuestion)
            }
            
        }
        return updatedQuestions
    }
    
    private func getUpdatedAnswerChoices(for question: Question) -> [[String:Any]]{
        var updatedAnswerChoices : [[String:Any]] = [[:]]
        for answerChoice in question.answerChoices {
            let newAnswerChoice = [K.REQUEST_ID : answerChoice.id,
                                   K.REQUEST_NAME: answerChoice.name,
                                   K.REQUEST_SCORE :answerChoice.score] as [String : Any]
            updatedAnswerChoices.append(newAnswerChoice)
        }
        return updatedAnswerChoices
    }
}
