import Foundation

final class HistoryViewModel {
    
    // MARK: - Closures
    
    var onHistoryUpdated: (() -> Void)?
    var onStartQuiz: (() -> Void)?
    
    // MARK: - Properties
    
    private let historyManager: QuizHistoryManagerProtocol
    private var historyItems: [QuizHistoryItem] = []
    
    // MARK: - Computed Properties
    
    var isEmpty: Bool {
        return historyItems.isEmpty
    }
    
    var numberOfItems: Int {
        return historyItems.count
    }
    
    // MARK: - Init
    
    init(historyManager: QuizHistoryManagerProtocol = QuizHistoryManager()) {
        self.historyManager = historyManager
        loadHistory()
    }
    
    // MARK: - Methods
    
    func loadHistory() {
        historyItems = historyManager.getQuizHistory()
        onHistoryUpdated?()
    }
    
    func getHistoryItem(at index: Int) -> QuizHistoryItem? {
        guard index >= 0 && index < historyItems.count else { return nil }
        return historyItems[index]
    }
    
    func deleteHistoryItem(at index: Int) -> Bool {
        guard let item = getHistoryItem(at: index) else { return false }
        
        if historyManager.deleteQuizResult(withId: item.id) {
            historyItems.remove(at: index)
            onHistoryUpdated?()
            return true
        }
        return false
    }
    
    func startNewQuiz() {
        onStartQuiz?()
    }
    
    // MARK: - Formatting Helpers
    
    func getFormattedDate(for item: QuizHistoryItem) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter.string(from: item.date)
    }
    
    func getFormattedTime(for item: QuizHistoryItem) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: item.date)
    }
    
    func getQuizTitle(for index: Int) -> String {
        return "Quiz \(index + 1)"
    }
}
