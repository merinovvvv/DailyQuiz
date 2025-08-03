//
//  QuizHistoryManagerProtocol.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 3.08.25.
//

import Foundation

protocol QuizHistoryManagerProtocol {
    func addQuizResult(_ result: QuizResult)
    func getQuizHistory() -> [QuizHistoryItem]
    func deleteQuizResult(withId id: UUID) -> Bool
}
