//
//  HomeViewModel.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import Foundation

final class HomeViewModel {
    
    //MARK: - Closures
    
    var showLoading: (() -> Void)?
    var hideLoading: (() -> Void)?
    var showError: ((String) -> Void)?
    var navigateToQuiz: (([Task]) -> Void)?
    
    //MARK: - Methods
    
    func startQuiz() {
        showLoading?()
        
        NetworkManager.shared.fetchQuizData { [weak self] result in
            DispatchQueue.main.async {
                self?.hideLoading?()
                
                switch result {
                case .success(let tasks):
                    self?.navigateToQuiz?(tasks)
                case .failure(let error):
                    guard let error = error as? NetworkError else {
                        self?.handleError(NetworkError.unknown)
                        return
                    }
                    self?.handleError(error)
                }
            }
        }
    }
    
    func handleError(_ error: NetworkError) {
        let errorMessage: String
        
        switch error {
        case .unknown: errorMessage = "Неизвестная ошибка"
        case .badURL: errorMessage = "Ошибка URL"
        case .invalidData: errorMessage = "Неверные данные"
        case .badRequest: errorMessage = "Ошибка сети"
        case .badResponse: errorMessage = "Неверный ответ сервера"
        case .decodingFailed: errorMessage = "Ошибка обработки данных"
        }
        
        showError?(errorMessage)
    }
}
