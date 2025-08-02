//
//  NetworkManager.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import Foundation

//MARK: - NetworkError
enum NetworkError: Error {
    case badURL
    case badRequest(String = "An unknown error occured.")
    case badResponse
    case decodingFailed(String = "Error parsing server response")
    case invalidData
    case unknown
}

//MARK: - NetworkManager
final class NetworkManager {
    static let shared = NetworkManager(); private init() { }
    
    private func createURL(with stringUrl: String) -> URL? {
        URL(string: stringUrl)
    }
    
    func fetchQuizData(completion: @escaping (Result<[Task], Error>) -> Void) {
        guard let url = createURL(with: "https://opentdb.com/api.php?amount=5") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                if let error {
                    completion(.failure(NetworkError.badRequest(error.localizedDescription)))
                }
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let quizData = try JSONDecoder().decode(QuizData.self, from: data)
                if quizData.responseCode == 0 {
                    completion(.success(quizData.results))
                } else {
                    completion(.failure(NetworkError.badResponse))
                }
            } catch {
                completion(.failure(NetworkError.decodingFailed(error.localizedDescription)))
            }
        }.resume()
    }
}
