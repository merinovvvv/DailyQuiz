//
//  QuizViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import UIKit

final class QuizViewController: UIViewController {
    
    //MARK: - Variables
    
    private let viewModel: QuizViewModel = QuizViewModel()
    private var tasks: [Task]
    private var selectedAnswerIndex: Int?
    
    //MARK: - Constants
    
    private enum Constants {
        
        //MARK: - Constraints
        static let dailyQuizImageViewTopSpacing: CGFloat = 35
        static let dailyQuizImageViewHorizontalSpacing: CGFloat = 106
        static let dailyQuizImageViewHeightMultipler: CGFloat = 67.67/300
        
        static let backButtonTopSpacing: CGFloat = 43
        static let backButtonLeadingSpacing: CGFloat = 26
        static let backButtonTrailingAnchor: CGFloat = 56
        
        static let questionViewTopSpacing: CGFloat = 40
        static let questionViewHorizontalSpacing: CGFloat = 26
        
        static let questionStackTopSpacing: CGFloat = 32
        static let questionStackHorizontalSpacing: CGFloat = 24
        
        static let answersStackHorizontalSpacing: CGFloat = 6
        
        static let nextButtonTopSpacing: CGFloat = 67
        static let nextButtonHorizontalSpacing: CGFloat = 30
        static let nextButtonBottomSpacing: CGFloat = 32
        
        
        //MARK: - Values
        
        
    }
    
    //MARK: - UI Components
    
    private let dailyQuizImageView: UIImageView = UIImageView()
    
    private let backButton: UIButton = UIButton(type: .system)
    
    private let questionView: UIView = UIView()
    private let questionStack: UIStackView = UIStackView()
    private let questionNumberLabel: UILabel = UILabel()
    private let questionLabel: UILabel = UILabel()
    private let answersStack: UIStackView = UIStackView()
    private let answerButtons: [AnswerOptionButton] = []

    private let nextButton: UIButton = UIButton()
    
    private let warningLabel: UILabel = UILabel()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
    }
    
    //MARK: - Init
    
    init(tasks: [Task]) {
        self.tasks = tasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup UI
private extension QuizViewController {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func setupViewHierarchy() {
        view.addSubview(dailyQuizImageView)
        view.addSubview(backButton)
        view.addSubview(questionView)
        
        questionView.addSubview(questionStack)
        
        questionStack.addSubview(questionNumberLabel)
        questionStack.addSubview(questionLabel)
        questionStack.addSubview(answersStack)
        answerButtons.forEach { answersStack.addArrangedSubview($0) }
        
        questionView.addSubview(nextButton)
        
        view.addSubview(warningLabel)
    }
    
    func setupConstraints() {
    
        dailyQuizImageView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionStack.translatesAutoresizingMaskIntoConstraints = false
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        answersStack.translatesAutoresizingMaskIntoConstraints = false
        
        answerButtons.forEach { button in
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dailyQuizImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.dailyQuizImageViewTopSpacing),
            dailyQuizImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dailyQuizImageViewHorizontalSpacing),
            dailyQuizImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.dailyQuizImageViewHorizontalSpacing),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.backButtonTopSpacing),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingSpacing),
            backButton.trailingAnchor.constraint(equalTo: dailyQuizImageView.leadingAnchor, constant: -Constants.backButtonTrailingAnchor),
            
            questionView.topAnchor.constraint(equalTo: dailyQuizImageView.bottomAnchor, constant: Constants.questionViewTopSpacing),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.questionViewHorizontalSpacing),
            questionView.trailingAnchor.constraint(equalTo: dailyQuizImageView.trailingAnchor, constant: -Constants.questionViewHorizontalSpacing),
            
            questionStack.topAnchor.constraint(equalTo: questionView.topAnchor, constant: Constants.questionStackTopSpacing),
            questionStack.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: Constants.questionStackHorizontalSpacing),
            questionStack.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -Constants.questionStackHorizontalSpacing),
            
            answersStack.leadingAnchor.constraint(equalTo: questionStack.leadingAnchor, constant: Constants.answersStackHorizontalSpacing),
            answersStack.trailingAnchor.constraint(equalTo: questionStack.trailingAnchor, constant: -Constants.answersStackHorizontalSpacing),
            
            nextButton.topAnchor.constraint(equalTo: questionStack.bottomAnchor, constant: Constants.nextButtonTopSpacing),
            nextButton.leadingAnchor.constraint(equalTo: questionStack.leadingAnchor, constant: Constants.nextButtonHorizontalSpacing),
            nextButton.trailingAnchor.constraint(equalTo: questionStack.trailingAnchor, constant: -Constants.nextButtonHorizontalSpacing),
            nextButton.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -Constants.nextButtonBottomSpacing),
        ])
    }
    
    //TODO: - configure views
    func configureViews() {
        
    }
}

//MARK: - Selectors
