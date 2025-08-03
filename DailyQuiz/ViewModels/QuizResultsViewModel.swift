import Foundation

final class QuizResultsViewModel {
    
    // MARK: - Variables
    private let result: QuizResult
    private let historyManager: QuizHistoryManagerProtocol
    
    // MARK: - Closures
    var navigateToHome: (() -> Void)?
    
    // MARK: - Data Arrays
    private let ratingTitleTexts: [String] = [
        "Совсем не наш день?",
        "Уже есть искра!",
        "На полпути к знаниям",
        "Тройка — хорошая база",
        "Почти идеально!",
        "Полный фарш: 5 из 5!"
    ]
    
    private let ratingSubtitleTexts: [String] = [
        "Ты начал с нуля, но каждый путь начинается именно с первого шага — подключайся к разбору ошибок и попробуй ещё раз.",
        "Один правильный ответ — это твоё начало. Давай укрепим фундамент: разбери ошибки и двигайся вперёд.",
        "Два правильных — уже лучше. Видишь, какие темы подзабыты? Понимаем, разбираем, и будешь увереннее.",
        "Ты на базовом уровне. Есть пробелы, но потенциал очевиден. Разбор ответов усилит твои знания.",
        "4/5 — очень близко к совершенству. Ещё один шаг!",
        "Абсолютный результат — огонь! Ты знаешь тему на отлично. Интересен новый уровень? Смотри следующие задания."
    ]
    
    // MARK: - Init
    init(result: QuizResult, historyManager: QuizHistoryManagerProtocol = QuizHistoryManager()) {
        self.result = result
        self.historyManager = historyManager
        
        saveResultToHistory()
    }
    
    // MARK: - Methods
    
    func getTotalQuestions() -> Int {
        return result.totalQuestions
    }
    
    func getCorrectAnswers() -> Int {
        return result.correctAnswers
    }
    
    func getScoreText() -> String {
        return "\(result.correctAnswers) из \(result.totalQuestions)"
    }
    
    func getRatingTitle() -> String {
        let index = result.correctAnswers
        return ratingTitleTexts[index]
    }
    
    func getRatingSubtitle() -> String {
        let index = result.correctAnswers
        return ratingSubtitleTexts[index]
    }
    
    func isStarFilled(at index: Int) -> Bool {
        return index < result.correctAnswers
    }
    
    func restartQuiz() {
        navigateToHome?()
    }
    
    private func saveResultToHistory() {
        historyManager.addQuizResult(result)
    }
}
