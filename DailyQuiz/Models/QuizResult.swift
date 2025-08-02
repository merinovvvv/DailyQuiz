//
//  QuizResult.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 2.08.25.
//

struct QuizResult {
    let totalQuestions: Int
    let correctAnswers: Int
    let percentage: Double
    let userAnswers: [UserAnswer]
    
    var scoreText: String {
        return "\(correctAnswers)/\(totalQuestions)"
    }
    
    var percentageText: String {
        return String(format: "%.1f%%", percentage)
    }
}
