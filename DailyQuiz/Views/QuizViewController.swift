//
//  QuizViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import UIKit

final class QuizViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Variables
    
    private let viewModel: QuizViewModel = QuizViewModel()
    private var tasks: [Task]
    private var questionIndex: Int = 0
    
    private var selectedAnswerIndex: Int?
    private var selectedAnswer: String?
    private var userAnswers: [String] = []
    
    //MARK: - Constants
    
    private enum Constants {
        
        //MARK: - Constraints
        static let dailyQuizImageViewTopSpacing: CGFloat = 35
        static let dailyQuizImageViewHorizontalSpacing: CGFloat = 106
        static let dailyQuizImageViewHeightMultipler: CGFloat = 67.67/300
        
        static let backButtonLeadingSpacing: CGFloat = 26
        static let backButtonTrailingAnchor: CGFloat = 56
        static let backButtonSize: CGFloat = 24
        
        static let questionViewTopSpacing: CGFloat = 40
        static let questionViewHorizontalSpacing: CGFloat = 26
        
        static let questionNumberLabelTopSpacing: CGFloat = 32
        static let questionNumberLabelHorizontalSpacing: CGFloat = 24
        
        static let questionLabelSpacing: CGFloat = 24
        
        static let answersStackTopSpacing: CGFloat = 24
        static let answersStackHorizontalSpacing: CGFloat = 30
        
        static let nextButtonTopSpacing: CGFloat = 67
        static let nextButtonHorizontalSpacing: CGFloat = 30
        static let nextButtonBottomSpacing: CGFloat = 32
        
        static let warningLabelTopSpacing: CGFloat = 16
        static let warningLabelHorizontalSpacing: CGFloat = 88
        
        static let nextButtonHeightMultiplier: CGFloat = 50/280
        
        //MARK: - Values
        static let questionViewCornerRadius: CGFloat = 46
        
        static let questionNumberLabelFontSize: CGFloat = 16
        
        static let questionLabelFontSize: CGFloat = 18
        
        static let answerStackContentSpacing: CGFloat = 16
        
        static let nextButtonCornerRadius: CGFloat = 16
        static let nextButtonTextSize: CGFloat = 16
        
        static let warningLabelFontSize: CGFloat = 10
    }
    
    //MARK: - UI Components
    
    private let dailyQuizImageView: UIImageView = UIImageView()
    
    private let backButton: UIButton = UIButton(type: .system)
    
    private let questionView: UIView = UIView()
    private let questionNumberLabel: UILabel = UILabel()
    private let questionLabel: UILabel = UILabel()
    private let answersStack: UIStackView = UIStackView()
    private var answerButtons: [RadioButtonView] = []
    
    private let nextButton: UIButton = UIButton(type: .system)
    
    private let warningLabel: UILabel = UILabel()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        setupUI()
        loadCurrentQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Init
    
    init(tasks: [Task]) {
        self.tasks = tasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    
    private func loadCurrentQuestion() {
        guard questionIndex < tasks.count else { return }
        
        let currentTask = tasks[questionIndex]
        
        questionLabel.text = currentTask.question
        questionNumberLabel.text = "Вопрос \(questionIndex + 1) из \(tasks.count)"
        
        clearAnswerButtons()
        
        createAnswerButtons(for: currentTask)
        
        selectedAnswerIndex = nil
        updateNextButtonState()
    }
    
    private func clearAnswerButtons() {
        answerButtons.forEach { button in
            answersStack.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        answerButtons.removeAll()
    }
    
    private func createAnswerButtons(for task: Task) {
        var allAnswers = task.incorrectAnswers
        allAnswers.append(task.correctAnswer)
        allAnswers.shuffle()
        
        for (index, answer) in allAnswers.enumerated() {
            let radioButton = RadioButtonView(title: answer)
            
            radioButton.onSelect = { [weak self] in
                self?.selectAnswer(at: index, selectedAnswer: answer)
            }
            
            answerButtons.append(radioButton)
            answersStack.addArrangedSubview(radioButton)
        }
    }
    
    private func selectAnswer(at index: Int, selectedAnswer: String) {
        
        selectedAnswerIndex = index
        
        answerButtons.forEach { $0.isSelectedOption = false }
        
        answerButtons[index].isSelectedOption = true
        self.selectedAnswer = selectedAnswer
        
        updateNextButtonState()
    }
    
    private func updateNextButtonState() {
        if selectedAnswerIndex != nil {
            nextButton.backgroundColor = UIColor(named: "lilac")
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = UIColor(named: "disabledColor")
            nextButton.isEnabled = false
        }
    }
    
    private func goToNextQuestion() {
        guard selectedAnswerIndex != nil else { return }
        
        questionIndex += 1
        
        if questionIndex < tasks.count {
            loadCurrentQuestion()
        } else {
            print("Quiz completed!")
        }
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
        
        questionView.addSubview(questionNumberLabel)
        questionView.addSubview(questionLabel)
        questionView.addSubview(answersStack)
        
        answerButtons.forEach { answersStack.addArrangedSubview($0) }
        
        questionView.addSubview(nextButton)
        
        view.addSubview(warningLabel)
    }
    
    func setupConstraints() {
        
        dailyQuizImageView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
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
            
            backButton.centerYAnchor.constraint(equalTo: dailyQuizImageView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingSpacing),
            backButton.trailingAnchor.constraint(equalTo: dailyQuizImageView.leadingAnchor, constant: -Constants.backButtonTrailingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonSize),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            questionView.topAnchor.constraint(equalTo: dailyQuizImageView.bottomAnchor, constant: Constants.questionViewTopSpacing),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.questionViewHorizontalSpacing),
            questionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.questionViewHorizontalSpacing),
            
            questionNumberLabel.topAnchor.constraint(equalTo: questionView.topAnchor, constant: Constants.questionNumberLabelTopSpacing),
            questionNumberLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: Constants.questionNumberLabelHorizontalSpacing),
            questionNumberLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -Constants.questionNumberLabelHorizontalSpacing),
            
            questionLabel.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: Constants.questionLabelSpacing),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: Constants.questionLabelSpacing),
            questionLabel.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -Constants.questionLabelSpacing),
            
            answersStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: Constants.answersStackTopSpacing),
            answersStack.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: Constants.answersStackHorizontalSpacing),
            answersStack.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -Constants.answersStackHorizontalSpacing),
            
            nextButton.topAnchor.constraint(equalTo: answersStack.bottomAnchor, constant: Constants.nextButtonTopSpacing),
            nextButton.leadingAnchor.constraint(equalTo: questionView.leadingAnchor, constant: Constants.nextButtonHorizontalSpacing),
            nextButton.trailingAnchor.constraint(equalTo: questionView.trailingAnchor, constant: -Constants.nextButtonHorizontalSpacing),
            nextButton.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -Constants.nextButtonBottomSpacing),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: Constants.nextButtonHeightMultiplier),
            
            warningLabel.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: Constants.warningLabelTopSpacing),
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func configureViews() {
        backButton.setImage(UIImage(named: "leftIcon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.contentHorizontalAlignment = .fill
        backButton.contentVerticalAlignment = .fill
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
        dailyQuizImageView.image = UIImage(named: "dailyQuizLogo")
        dailyQuizImageView.contentMode = .scaleAspectFit
        
        questionView.layer.cornerRadius = Constants.questionViewCornerRadius
        questionView.backgroundColor = .white
        
        questionNumberLabel.text = "Вопрос \(questionIndex + 1) из \(tasks.count)"
        questionNumberLabel.font = UIFont.systemFont(ofSize: Constants.questionNumberLabelFontSize, weight: .bold)
        questionNumberLabel.textColor = UIColor(named: "lightLilac")
        questionNumberLabel.textAlignment = .center
        
        questionLabel.text = tasks[questionIndex].question
        questionLabel.numberOfLines = .zero
        questionLabel.font = UIFont.systemFont(ofSize: Constants.questionLabelFontSize, weight: .semibold)
        questionLabel.textColor = .black
        questionLabel.textAlignment = .center
        
        answersStack.axis = .vertical
        answersStack.spacing = Constants.answerStackContentSpacing
        answersStack.alignment = .fill
        answersStack.distribution = .fillEqually
        
        nextButton.setTitle("далее".uppercased(), for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.nextButtonTextSize, weight: .black)
        nextButton.backgroundColor = UIColor(named: "disabledColor")
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = Constants.nextButtonCornerRadius
        
        warningLabel.text = "Вернуться к предыдущим вопросам нельзя"
        warningLabel.font = UIFont.systemFont(ofSize: Constants.warningLabelFontSize, weight: .regular)
        warningLabel.textColor = .white
        warningLabel.textAlignment = .center
    }
}

//MARK: - Selectors
private extension QuizViewController {
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
