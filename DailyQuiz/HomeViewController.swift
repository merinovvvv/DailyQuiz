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
        //MARK: - Spacings
        
        static let historyButtonTopSpacing: CGFloat = 46
        
        static let dailyQuizImageViewTopSpacing: CGFloat = 114
        
        static let welcomeViewTopSpacing: CGFloat = 40
        
        static let welcomeStackVerticalSpacing: CGFloat = 32
        static let welcomeStackHorizontalSpacing: CGFloat = 24
        static let welcomeStackContentSpacing: CGFloat = 40
        
        static let historyButtonContentSpacing: CGFloat = 12
        
        //MARK: - Values
        
        static let historyButtonCornedRadius: CGFloat = 24
        static let historyButtonTextSize: CGFloat = 12
        static let historyButtonImageSize: CGFloat = 16
        
        static let dailyQuizImageViewSize: CGSize = CGSize(width: 300, height: 67.67)
        
        static let welcomeViewCornerRadius: CGFloat = 46
        static let welcomeViewWidth: CGFloat = 360
        static let welcomeLabelFontSize: CGFloat = 28
        
        static let startButtonTextFontSize: CGFloat = 16
        static let startButtonCornerRadius: CGFloat = 16
        static let startButtonSize: CGSize = CGSize(width: 280, height: 50)
        
        
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
            historyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.historyButtonTopSpacing),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            dailyQuizImageView.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: Constants.dailyQuizImageViewTopSpacing),
            dailyQuizImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dailyQuizImageView.widthAnchor.constraint(equalToConstant: Constants.dailyQuizImageViewSize.width),
            dailyQuizImageView.heightAnchor.constraint(equalToConstant: Constants.dailyQuizImageViewSize.height),
            
            
            welcomeView.topAnchor.constraint(equalTo: dailyQuizImageView.bottomAnchor, constant: Constants.welcomeViewTopSpacing),
            welcomeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeView.widthAnchor.constraint(equalToConstant: Constants.welcomeViewWidth),
            
            welcomeStack.topAnchor.constraint(equalTo: welcomeView.topAnchor, constant: Constants.welcomeStackVerticalSpacing),
            welcomeStack.bottomAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: -Constants.welcomeStackVerticalSpacing),
            welcomeStack.leadingAnchor.constraint(equalTo: welcomeView.leadingAnchor, constant: Constants.welcomeStackHorizontalSpacing),
            welcomeStack.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor, constant: -Constants.welcomeStackHorizontalSpacing),
            
            startButton.widthAnchor.constraint(equalToConstant: Constants.startButtonSize.width),
            startButton.heightAnchor.constraint(equalToConstant: Constants.startButtonSize.height),
            
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
        
        historyButtonConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(
            pointSize: Constants.historyButtonImageSize,
        )
        
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
