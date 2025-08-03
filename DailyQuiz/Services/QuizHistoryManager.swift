//
//  QuizHistoryManager.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 3.08.25.
//

import Foundation

final class QuizHistoryManager: QuizHistoryManagerProtocol {
    
    //MARK: - Properties
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    private let historyKey = "quizHistory"
    private var historyItems: [QuizHistoryItem] = []
    
    //MARK: - Init
    
    init() {
        loadHistory()
    }
    
    //MARK: - Public Methods
    
    func addQuizResult(_ result: QuizResult) {
        let quizHistoryItem = QuizHistoryItem(from: result)
        historyItems.append(quizHistoryItem)
        saveHistory()
    }
    
    func getQuizHistory() -> [QuizHistoryItem] {
        return historyItems.sorted { $1.date > $0.date }
    }
    
    func deleteQuizResult(withId id: UUID) -> Bool {
        guard let index = historyItems.firstIndex(where: { $0.id == id }) else {
            print("Quiz result with ID \(id) not found")
            return false
        }
        
        let removedItem = historyItems.remove(at: index)
        saveHistory()
        print("Deleted quiz result: \(removedItem.correctAnswers)/\(removedItem.totalQuestions)")
        return true
    }
    
    //MARK: - Private Methods
    
    private func loadHistory() {
        guard let data = userDefaults.data(forKey: historyKey) else {
            print("No quiz history found")
            historyItems = []
            return
        }
        do {
            historyItems = try JSONDecoder().decode([QuizHistoryItem].self, from: data)
            print("Loaded \(historyItems.count) quiz history items")
        } catch {
            print("Failed to decode quiz history: \(error)")
            historyItems = []
        }
    }
    
    private func saveHistory() {
        do {
            let encodedHistoryItems = try JSONEncoder().encode(historyItems)
            userDefaults.set(encodedHistoryItems, forKey: historyKey)
            print("Saved \(historyItems.count) quiz history items")
        } catch {
            print("Failed to encode quiz history: \(error)")
        }
    }
}
