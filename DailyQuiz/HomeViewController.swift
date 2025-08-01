//
//  ViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Variables
    

    //MARK: - Constants
    private enum Constants {
        //MARK: - Constraints
        
        static let historyButtonTopSpacing: CGFloat = 100
        static let historyButtonContentSpacing: CGFloat = 12
        static let historyButtonHeightMultiplier: CGFloat = 40/103
        
        static let dailyQuizImageViewTopSpacing: CGFloat = 114
        static let dailyQuizImageViewLeadingSpacing: CGFloat = 46
        static let dailyQuizImageViewTrailingSpacing: CGFloat = 47
        static let dailyQuizImageViewHeightMultipler: CGFloat = 67.67/300
        
        static let welcomeViewTopSpacing: CGFloat = 40
        static let welcomeViewBottomSpacing: CGFloat = 268.33
        
        static let welcomeStackVerticalSpacing: CGFloat = 32
        static let welcomeStackHorizontalSpacing: CGFloat = 24
        static let welcomeStackContentSpacing: CGFloat = 40
        
        static let startButtonSpacingToStack: CGFloat = 16
        static let startButtonHeightMultiplier: CGFloat = 50/280
        
        //MARK: - Values
        
        static let historyButtonCornedRadius: CGFloat = 24
        static let historyButtonTextSize: CGFloat = 12
        
        static let welcomeViewCornerRadius: CGFloat = 46
        static let welcomeViewLeadingSpacing: CGFloat = 16
        static let welcomeViewTrailingSpacing: CGFloat = 17
        static let welcomeLabelFontSize: CGFloat = 28
        
        static let startButtonTextFontSize: CGFloat = 16
        static let startButtonCornerRadius: CGFloat = 16
        static let startButtonSpacing: CGFloat = 16
    }

    //MARK: - UI Components
    
    private let historyButton: UIButton = UIButton()
    private var historyButtonConfig: UIButton.Configuration = UIButton.Configuration.filled()
    
    private let dailyQuizImageView: UIImageView = UIImageView()
    
    private let welcomeView: UIView = UIView()
    private let welcomeLabel: UILabel = UILabel()
    private let startButton: UIButton = UIButton()
    private let welcomeStack: UIStackView = UIStackView()
    

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
        setupUI()
    }
}

//MARK: - Setup UI

private extension HomeViewController {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func setupViewHierarchy() {
        view.addSubview(historyButton)
        view.addSubview(dailyQuizImageView)
        view.addSubview(welcomeView)
        welcomeView.addSubview(welcomeStack)
        welcomeStack.addArrangedSubview(welcomeLabel)
        welcomeStack.addArrangedSubview(startButton)
    }
    
    func setupConstraints() {
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        dailyQuizImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        welcomeStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.historyButtonTopSpacing),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyButton.heightAnchor.constraint(equalTo: historyButton.widthAnchor, multiplier: Constants.historyButtonHeightMultiplier),
            
            dailyQuizImageView.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: Constants.dailyQuizImageViewTopSpacing),
            dailyQuizImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dailyQuizImageViewLeadingSpacing),
            dailyQuizImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.dailyQuizImageViewTrailingSpacing),
            dailyQuizImageView.heightAnchor.constraint(equalTo: dailyQuizImageView.widthAnchor, multiplier: Constants.dailyQuizImageViewHeightMultipler),
            
            
            welcomeView.topAnchor.constraint(equalTo: dailyQuizImageView.bottomAnchor, constant: Constants.welcomeViewTopSpacing),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.welcomeViewLeadingSpacing),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.welcomeViewTrailingSpacing),
            welcomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.welcomeViewBottomSpacing),
            
            
            welcomeStack.topAnchor.constraint(equalTo: welcomeView.topAnchor, constant: Constants.welcomeStackVerticalSpacing),
            welcomeStack.bottomAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: -Constants.welcomeStackVerticalSpacing),
            welcomeStack.leadingAnchor.constraint(equalTo: welcomeView.leadingAnchor, constant: Constants.welcomeStackHorizontalSpacing),
            welcomeStack.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor, constant: -Constants.welcomeStackHorizontalSpacing),
            
            startButton.leadingAnchor.constraint(equalTo: welcomeStack.leadingAnchor, constant: Constants.startButtonSpacingToStack),
            startButton.trailingAnchor.constraint(equalTo: welcomeStack.trailingAnchor, constant: -Constants.startButtonSpacingToStack),
            startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: Constants.startButtonHeightMultiplier)
        ])
    }
    
    func configureViews() {
        configureHistoryButton()
        
        dailyQuizImageView.image = UIImage(named: "dailyQuizLogo")
        dailyQuizImageView.contentMode = .scaleAspectFit
        
        welcomeView.layer.cornerRadius = Constants.welcomeViewCornerRadius
        welcomeView.backgroundColor = .white
        
        welcomeLabel.text = "Добро пожаловать \nв DailyQuiz!"
        welcomeLabel.numberOfLines = .zero
        welcomeLabel.font = UIFont.systemFont(ofSize: Constants.welcomeLabelFontSize, weight: .bold)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        
        startButton.setTitle("начать викторину".uppercased(), for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.startButtonTextFontSize, weight: .black)
        startButton.layer.cornerRadius = Constants.startButtonCornerRadius
        startButton.backgroundColor = UIColor(named: "lilac")
        
        welcomeStack.axis = .vertical
        welcomeStack.spacing = Constants.welcomeStackContentSpacing
        welcomeStack.alignment = .center
        welcomeStack.distribution = .fill
    }
    
    func configureHistoryButton() {
        
        historyButtonConfig.title = "История"
        historyButtonConfig.image = UIImage(named: "historyIcon")
        historyButtonConfig.imagePlacement = .trailing
        historyButtonConfig.imagePadding = Constants.historyButtonContentSpacing
        historyButtonConfig.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.historyButtonContentSpacing,
            leading: Constants.historyButtonContentSpacing,
            bottom: Constants.historyButtonContentSpacing,
            trailing: Constants.historyButtonContentSpacing
        )
        
        historyButtonConfig.background.cornerRadius = Constants.historyButtonCornedRadius
        
        historyButtonConfig.baseBackgroundColor = .white
        historyButtonConfig.baseForegroundColor = UIColor(named: "lilac")
        
        historyButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: Constants.historyButtonTextSize, weight: .semibold)
            return outgoing
        }
        
        historyButton.configuration = historyButtonConfig
    }
}

//MARK: - Selectors
