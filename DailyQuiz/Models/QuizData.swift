//
//  QuizData.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import Foundation

// MARK: - QuizData
struct QuizData: Codable {
    let responseCode: Int
    let results: [Task]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct Task: Codable {
    let type, difficulty, category, question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
