//
//  RegisterViewModel.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation
import Combine

final class UserViewModel{
    private let validation = ValidationManager()
    private let endpoint: Endpoint?
    
    var userSubject = PassthroughSubject<Int, Error>()
    private var subscribers = Set<AnyCancellable>()
    
    init(endpoint: Endpoint?) {
        self.endpoint = endpoint
    }
    
    func validationCheck(_ userModel: UserModel) -> ValidationResult{
        let email = validation.email(userModel.email)
        let password = validation.password(userModel.password)
        guard email.isSuccess else {
            return email
        }
        guard password.isSuccess else {
            return password
        }
        return .init(error: nil, isSuccess: true)
    }
    
    func performAction(_ viewModel: UserModel) {
        guard let endpoint = endpoint else{
            self.userSubject.send(completion: .failure(APIError.apiError(reason: K.invalidInput)))
            return
        }
        let url = URL(string: endpoint.urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = K.HTTP_POST
        let parameterDictionary = [K.REQUEST_EMAIL : viewModel.email,
                                   K.REQUEST_PASSWORD :viewModel.password]
        request.setValue(K.application_json, forHTTPHeaderField: K.content_type)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, 
                                                         options: [])
        else {
            self.userSubject.send(completion: .failure(APIError.apiError(reason: K.invalidInput)))
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                self.userSubject.send(completion: .failure(APIError.apiError(reason: K.failedToRegisterUser)))
                return
            }
            self.userSubject.send(httpResponse.statusCode)
        }.resume()
    }

    
    
}
