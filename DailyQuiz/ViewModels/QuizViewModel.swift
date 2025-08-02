//
//  QuizViewModel.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import Foundation

final class QuizViewModel {
    
    //MARK: - Properties
    
    private var tasks: [Task]
    private(set) var currentQuestionIndex: Int = 0
    private(set) var userAnswers: [UserAnswer] = []
    private(set) var isQuizCompleted: Bool = false
    
    //MARK: - Closures
    
    var onQuestionChanged: (() -> Void)?
    var onQuizCompleted: ((QuizResult) -> Void)?
    var onNextButtonStateChanged: ((Bool) -> Void)?
    
    //MARK: - Computed Properties
    
    var totalQuestions: Int {
        return tasks.count
    }

    var currentQuestion: Task? {
        guard currentQuestionIndex < tasks.count else { return nil }
        return tasks[currentQuestionIndex]
    }
    
    var progressText: String {
        return "Вопрос \(currentQuestionIndex + 1) из \(totalQuestions)"
    }
    
    var currentQuestionAnswers: [String] {
        guard let currentTask = currentQuestion else { return [] }
        var answers = currentTask.incorrectAnswers
        answers.append(currentTask.correctAnswer)
        answers.shuffle()
        return answers
    }
    
    //MARK: - Init
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    //MARK: - Methods
    
    func selectAnswer(_ answer: String) {
        guard let currentTask = currentQuestion else { return }
        
        let userAnswer = UserAnswer(
            question: currentTask.question,
            selectedAnswer: answer,
            correctAnswer: currentTask.correctAnswer,
            isCorrect: answer == currentTask.correctAnswer
        )
        
        if currentQuestionIndex < userAnswers.count {
            userAnswers[currentQuestionIndex] = userAnswer
        } else {
            userAnswers.append(userAnswer)
        }
        
        onNextButtonStateChanged?(canProceedToNext())
    }
    
    func goToNextQuestion() {
        guard currentQuestionIndex < tasks.count - 1 else {
            isQuizCompleted = true
            onQuizCompleted?(getQuizResults())
            return
        }
        
        currentQuestionIndex += 1
        onQuestionChanged?()
        onNextButtonStateChanged?(canProceedToNext())
    }
    
    func canProceedToNext() -> Bool {
        return currentQuestionIndex < userAnswers.count
    }
    
    func getQuizResults() -> QuizResult {
        let correctAnswers = userAnswers.filter { $0.isCorrect }.count
        let totalQuestions = userAnswers.count
        let percentage = totalQuestions > 0 ? Double(correctAnswers) / Double(totalQuestions) * 100 : 0
        
        return QuizResult(
            totalQuestions: totalQuestions,
            correctAnswers: correctAnswers,
            percentage: percentage,
            userAnswers: userAnswers
        )
    }
    
    private func reset() {
        currentQuestionIndex = 0
        userAnswers.removeAll()
        isQuizCompleted = false
    }
}
