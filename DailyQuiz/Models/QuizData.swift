//
//  QuizData.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import Foundation

// MARK: - String Extension for HTML Decoding
extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}

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
    let type, difficulty, category: String
    private let _question: String
    private let _correctAnswer: String
    private let _incorrectAnswers: [String]
    
    var question: String {
        return _question.htmlDecoded
    }
    
    var correctAnswer: String {
        return _correctAnswer.htmlDecoded
    }
    
    var incorrectAnswers: [String] {
        return _incorrectAnswers.map { $0.htmlDecoded }
    }
    
    enum CodingKeys: String, CodingKey {
        case type, difficulty, category
        case _question = "question"
        case _correctAnswer = "correct_answer"
        case _incorrectAnswers = "incorrect_answers"
    }
}
