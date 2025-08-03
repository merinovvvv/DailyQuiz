//
//  QuizHistoryItem.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 3.08.25.
//

import Foundation

struct QuizHistoryItem: Codable {
    let id: UUID
    let date: Date
    let totalQuestions: Int
    let correctAnswers: Int
    
    init(from result: QuizResult) {
        self.id = UUID()
        self.date = Date()
        self.totalQuestions = result.totalQuestions
        self.correctAnswers = result.correctAnswers
    }
}
