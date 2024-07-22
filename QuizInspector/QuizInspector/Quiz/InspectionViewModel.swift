//
//  InspectionViewModel.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation
import Combine

class InspectionViewModel{
    // Dependency Injection
    private let apiManager: APIManagerService
    private let endpoint: Endpoint
    
    var inspectionSubject = PassthroughSubject<Root, Error>()
    
    init(apiManager: APIManagerService, endpoint: Endpoint) {
        self.apiManager = apiManager
        self.endpoint = endpoint
    }
    
    func fetchQuestions() {
        let url = URL(string: endpoint.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = K.HTTP_GET
        request.setValue(
            K.application_json,
            forHTTPHeaderField: K.content_type
        )
        apiManager.performRequest(request: request) { [weak self] (result: Result<Root, Error>) in
            switch result {
            case .success(let root):
                self?.inspectionSubject.send(root)
            case .failure(let error):
                self?.inspectionSubject.send(completion: .failure(error))
            }
        }
    }
    

    
    
}
