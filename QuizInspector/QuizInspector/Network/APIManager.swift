//
//  APIManager.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import Foundation
import Combine



protocol APIManagerService {
    func performRequest<T: Decodable>(request: URLRequest,
                                     completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerService {
    private var subscribers = Set<AnyCancellable>()
    func performRequest<T: Decodable>(request: URLRequest, 
                                     completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { (resultCompletion) in
                switch resultCompletion {
                case .failure(let error):
                    completion(.failure(error))
                case .finished: break
                }
            }, receiveValue: { (resultArray) in
                completion(.success(resultArray))
            }).store(in: &subscribers)
    }
}

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    var errorDescription: String? {
        switch self {
        case .unknown:
            return K.unknownError
        case .apiError(let reason):
            return reason
        }
    }
}

enum Endpoint {
    case questionsFetch
    case login
    case register
    case submit
    var urlString: String {
        switch self {
        case .questionsFetch:
            return K.baseURL + K.startInspection
        case .login:
            return K.baseURL + K.login
        case .register:
            return K.baseURL + K.register
        case.submit:
            return K.baseURL + K.submit

        }
    }
}
