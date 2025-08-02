//
//  QuizResultsViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 2.08.25.
//

import UIKit

final class QuizResultsViewController: UIViewController {
    
    
    //MARK: - Variables
    
    private let viewModel: QuizResultsViewModel
    
    //MARK: - Constants
    
    private enum Constants {
        
        //MARK: - Constraints
        
        static let titleLabelTopSpacing: CGFloat = 32
        
        static let resultViewTopSpacing: CGFloat = 40
        static let resultViewHorizontalSpacing: CGFloat = 26
        
        static let starStackTopSpacing: CGFloat = 32
        static let starStackHorizontalSpacing: CGFloat = 24
        
        static let scoreLabelTopSpacing: CGFloat = 24
        
        static let ratingTitleLabelTopSpacing: CGFloat = 24
        
        static let ratingSubtitleLabelTopSpacing: CGFloat = 12
        static let ratingSubtitleLabelHorizontalSpacing: CGFloat = 22
        
        static let restartButtonTopSpacing: CGFloat = 64
        static let restartButtonHorizontalSpacing: CGFloat = 30
        static let restartButtonBottomSpacing: CGFloat = 32
        static let restartButtonHeightMultiplier: CGFloat = 50/280
        
        //MARK: - Values
        
        static let titleLabelFontSize: CGFloat = 32
        
        static let resultViewCornerRadius: CGFloat = 46
        
        static let scoreLabelFontSize: CGFloat = 16
        
        static let ratingTitleLabelFontSize: CGFloat = 24
        
        static let ratingSubtitleLabelFontSize: CGFloat = 16
        
        static let restartButtonCornerRadius: CGFloat = 16
        static let restartButtonTextFontSize: CGFloat = 16
    }
    
    //MARK: - UI Components
    
    private let titleLabel: UILabel = UILabel()
    
    private let resultView: UIView = UIView()
    private let starStack: UIStackView = UIStackView()
    private let starImageView: UIImageView = UIImageView()
    private let scoreLabel: UILabel = UILabel()
    private let ratingTitleLabel: UILabel = UILabel()
    private let ratingSubtitleLabel: UILabel = UILabel()
    
    private let restartButton: UIButton = UIButton(type: .system)
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
        setupBindings()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Init
    
    init(result: QuizResult) {
        viewModel = QuizResultsViewModel(result: result)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupBindings() {
        viewModel.navigateToHome = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

//MARK: - Setup UI
private extension QuizResultsViewController {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func setupViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(resultView)
        
        resultView.addSubview(starStack)
        
        for i in 0..<viewModel.getTotalQuestions() {
            let starImageView = UIImageView()
            starImageView.image = UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
            starImageView.contentMode = .scaleAspectFit
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                starImageView.heightAnchor.constraint(equalTo: starImageView.widthAnchor)
            ])
            
            if viewModel.isStarFilled(at: i) {
                starImageView.tintColor = UIColor(named: "starYellow")
            } else {
                starImageView.tintColor = UIColor(named: "disabledColor")
            }
            
            starStack.addArrangedSubview(starImageView)
        }
        
        resultView.addSubview(scoreLabel)
        resultView.addSubview(ratingTitleLabel)
        resultView.addSubview(ratingSubtitleLabel)
        resultView.addSubview(restartButton)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        resultView.translatesAutoresizingMaskIntoConstraints = false
        starStack.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTopSpacing),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resultView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.resultViewTopSpacing),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.resultViewHorizontalSpacing),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.resultViewHorizontalSpacing),
            
            starStack.topAnchor.constraint(equalTo: resultView.topAnchor, constant: Constants.starStackTopSpacing),
            starStack.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: Constants.starStackHorizontalSpacing),
            starStack.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -Constants.starStackHorizontalSpacing),
            
            starImageView.heightAnchor.constraint(equalTo: starImageView.widthAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: starStack.bottomAnchor, constant: Constants.scoreLabelTopSpacing),
            scoreLabel.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            
            ratingTitleLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: Constants.ratingTitleLabelTopSpacing),
            ratingTitleLabel.centerXAnchor.constraint(equalTo: resultView.centerXAnchor),
            
            ratingSubtitleLabel.topAnchor.constraint(equalTo: ratingTitleLabel.bottomAnchor, constant: Constants.ratingSubtitleLabelTopSpacing),
            ratingSubtitleLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: Constants.ratingSubtitleLabelHorizontalSpacing),
            ratingSubtitleLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -Constants.ratingSubtitleLabelHorizontalSpacing),
            
            restartButton.topAnchor.constraint(equalTo: ratingSubtitleLabel.bottomAnchor, constant: Constants.restartButtonTopSpacing),
            restartButton.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: Constants.restartButtonHorizontalSpacing),
            restartButton.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -Constants.restartButtonHorizontalSpacing),
            restartButton.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -Constants.restartButtonBottomSpacing),
            restartButton.heightAnchor.constraint(equalTo: restartButton.widthAnchor, multiplier: Constants.restartButtonHeightMultiplier)
        ])
    }
    
    func configureViews() {
        titleLabel.text = "Результаты"
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .black)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        resultView.layer.cornerRadius = Constants.resultViewCornerRadius
        resultView.backgroundColor = .white
        
        starStack.axis = .horizontal
        starStack.alignment = .center
        starStack.distribution = .fillEqually
        
        starImageView.image = UIImage(systemName: "starIcon")
        starImageView.contentMode = .scaleAspectFit
        
        scoreLabel.text = viewModel.getScoreText()
        scoreLabel.textColor = UIColor(named: "starYellow")
        scoreLabel.font = UIFont.systemFont(ofSize: Constants.scoreLabelFontSize, weight: .bold)
        scoreLabel.textAlignment = .center
        
        ratingTitleLabel.text = viewModel.getRatingTitle()
        ratingTitleLabel.textColor = .black
        ratingTitleLabel.font = UIFont.systemFont(ofSize: Constants.ratingTitleLabelFontSize, weight: .bold)
        ratingTitleLabel.textAlignment = .center
        ratingTitleLabel.numberOfLines = .zero
        
        ratingSubtitleLabel.text = viewModel.getRatingSubtitle()
        ratingSubtitleLabel.textColor = .black
        ratingSubtitleLabel.font = UIFont.systemFont(ofSize: Constants.ratingSubtitleLabelFontSize, weight: .regular)
        ratingSubtitleLabel.textAlignment = .center
        ratingSubtitleLabel.numberOfLines = .zero
        
        restartButton.setTitle("начать заново".uppercased(), for: .normal)
        restartButton.layer.cornerRadius = Constants.restartButtonCornerRadius
        restartButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.restartButtonTextFontSize, weight: .black)
        restartButton.backgroundColor = UIColor(named: "lilac")
        restartButton.tintColor = .white
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }
}

//MARK: - Selectors
private extension QuizResultsViewController {
    @objc func restartButtonTapped() {
        viewModel.restartQuiz()
    }
}
