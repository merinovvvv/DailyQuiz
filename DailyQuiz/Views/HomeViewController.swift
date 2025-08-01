//
//  ViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Variables
    private let viewModel: HomeViewModel = HomeViewModel()
    
    //MARK: - Constants
    private enum Constants {
        //MARK: - Constraints
        
        static let historyButtonTopSpacing: CGFloat = 100
        static let historyButtonContentSpacing: CGFloat = 12
        static let historyButtonHeightMultiplier: CGFloat = 40/103
        
        static let dailyQuizImageViewTopSpacing: CGFloat = 114
        static let dailyQuizImageViewHorizontalSpacing: CGFloat = 46
        static let dailyQuizImageViewHeightMultipler: CGFloat = 67.67/300
        
        static let welcomeViewTopSpacing: CGFloat = 40
        
        static let welcomeStackVerticalSpacing: CGFloat = 32
        static let welcomeStackHorizontalSpacing: CGFloat = 24
        static let welcomeStackContentSpacing: CGFloat = 40
        static let welcomeViewHorizontalSpacing: CGFloat = 16
        
        static let startButtonSpacingToStack: CGFloat = 16
        static let startButtonHeightMultiplier: CGFloat = 50/280
        static let startButtonSpacing: CGFloat = 16
        
        static let errorLabelTopSpacing: CGFloat = 24
        static let errorLabelBottomSpacing: CGFloat = 224.33
        static let errorLabelHorizontalSpacing: CGFloat = 46
        
        //MARK: - Values
        static let one: CGFloat = 1
        
        static let historyButtonCornedRadius: CGFloat = 24
        static let historyButtonTextSize: CGFloat = 12
        
        static let welcomeViewCornerRadius: CGFloat = 46
        static let welcomeLabelFontSize: CGFloat = 28
        
        static let startButtonTextFontSize: CGFloat = 16
        static let startButtonCornerRadius: CGFloat = 16
        static let errorLabelTextSize: CGFloat = 20
    }
    
    //MARK: - UI Components
    
    private let historyButton: UIButton = UIButton()
    private var historyButtonConfig: UIButton.Configuration = UIButton.Configuration.filled()
    
    private let dailyQuizImageView: UIImageView = UIImageView()
    
    private let welcomeView: UIView = UIView()
    private let welcomeLabel: UILabel = UILabel()
    private let startButton: UIButton = UIButton()
    private let welcomeStack: UIStackView = UIStackView()
    
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    private let errorLabel: UILabel = UILabel()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        errorLabel.isHidden = true
        
        welcomeView.isHidden = false
        historyButton.isHidden = false
        welcomeView.alpha = .zero
        historyButton.alpha = .zero
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut) {
            self.welcomeView.alpha = Constants.one
            self.historyButton.alpha = Constants.one
        }
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
        view.addSubview(activityIndicator)
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            historyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.historyButtonTopSpacing),
            historyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            historyButton.heightAnchor.constraint(equalTo: historyButton.widthAnchor, multiplier: Constants.historyButtonHeightMultiplier),
            
            dailyQuizImageView.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: Constants.dailyQuizImageViewTopSpacing),
            dailyQuizImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dailyQuizImageViewHorizontalSpacing),
            dailyQuizImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.dailyQuizImageViewHorizontalSpacing),
            dailyQuizImageView.heightAnchor.constraint(equalTo: dailyQuizImageView.widthAnchor, multiplier: Constants.dailyQuizImageViewHeightMultipler),
            
            welcomeView.topAnchor.constraint(equalTo: dailyQuizImageView.bottomAnchor, constant: Constants.welcomeViewTopSpacing),
            welcomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.welcomeViewHorizontalSpacing),
            welcomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.welcomeViewHorizontalSpacing),

            welcomeStack.topAnchor.constraint(equalTo: welcomeView.topAnchor, constant: Constants.welcomeStackVerticalSpacing),
            welcomeStack.bottomAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: -Constants.welcomeStackVerticalSpacing),
            welcomeStack.leadingAnchor.constraint(equalTo: welcomeView.leadingAnchor, constant: Constants.welcomeStackHorizontalSpacing),
            welcomeStack.trailingAnchor.constraint(equalTo: welcomeView.trailingAnchor, constant: -Constants.welcomeStackHorizontalSpacing),
            
            startButton.leadingAnchor.constraint(equalTo: welcomeStack.leadingAnchor, constant: Constants.startButtonSpacingToStack),
            startButton.trailingAnchor.constraint(equalTo: welcomeStack.trailingAnchor, constant: -Constants.startButtonSpacingToStack),
            startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: Constants.startButtonHeightMultiplier),
            
            activityIndicator.centerXAnchor.constraint(equalTo: welcomeView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: welcomeView.centerYAnchor),
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
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        welcomeStack.axis = .vertical
        welcomeStack.spacing = Constants.welcomeStackContentSpacing
        welcomeStack.alignment = .center
        welcomeStack.distribution = .fill
        
        errorLabel.text = "Ошибка! Попробуйте ещё раз"
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: Constants.errorLabelTextSize, weight: .bold)
        errorLabel.textColor = .white
        
        activityIndicator.isHidden = true
        activityIndicator.color = .white
        activityIndicator.style = .large
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

//MARK: - MVVM interaction
private extension HomeViewController {
    //MARK: - Setup Bindings
    private func setupBindings() {
        viewModel.showLoading = { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.activityIndicator.isHidden = false
            strongSelf.activityIndicator.startAnimating()
            strongSelf.activityIndicator.alpha = .zero
            
            UIView.animate(withDuration: 0.3, animations: {
                strongSelf.welcomeView.alpha = .zero
                strongSelf.historyButton.alpha = .zero
            }) { _ in
                strongSelf.welcomeView.isHidden = true
                strongSelf.historyButton.isHidden = true
                
                UIView.animate(withDuration: 0.2) {
                    strongSelf.activityIndicator.alpha = Constants.one
                }
            }
        }
        
        viewModel.hideLoading = { [weak self] in
            
            guard let strongSelf = self else { return }
            
            UIView.animate(withDuration: 0.2, animations: {
                strongSelf.activityIndicator.alpha = .zero
            }) { _ in
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.activityIndicator.isHidden = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    guard let strongSelf = self else { return }
                    if strongSelf.navigationController?.topViewController == self {
                        strongSelf.welcomeView.alpha = .zero
                        strongSelf.historyButton.alpha = .zero
                        strongSelf.welcomeView.isHidden = false
                        strongSelf.historyButton.isHidden = false
                        
                        UIView.animate(withDuration: 0.3) {
                            strongSelf.welcomeView.alpha = Constants.one
                            strongSelf.historyButton.alpha = Constants.one
                        }
                    }
                }
            }
            
            
            //self?.hideLoadingIndicator()
        }
        
        viewModel.showError = { [weak self] message in
            self?.showErrorLabel()
        }
        
        viewModel.navigateToQuiz = { [weak self] tasks in
            let quizVC = QuizViewController(tasks: tasks)
            self?.navigationController?.pushViewController(quizVC, animated: true)
        }
    }
    
//    private func hideLoadingIndicator() {
//        activityIndicator.stopAnimating()
//        activityIndicator.isHidden = true
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
//            guard let strongSelf = self else { return }
//            
//            strongSelf.welcomeView.alpha = 0
//            strongSelf.welcomeView.isHidden = false
//            
//            strongSelf.historyButton.alpha = 0
//            strongSelf.historyButton.isHidden = false
//            
//            UIView.animate(withDuration: 0.3) {
//                strongSelf.welcomeView.alpha = 1
//                strongSelf.historyButton.alpha = 1
//            }
//        }
//    }
    
    private func showErrorLabel() {
        if !view.contains(errorLabel) {
            view.addSubview(errorLabel)
            
            errorLabel.isHidden = true
            
            NSLayoutConstraint.activate([
                errorLabel.topAnchor.constraint(equalTo: welcomeView.bottomAnchor, constant: Constants.errorLabelTopSpacing),
                errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.errorLabelHorizontalSpacing),
                errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.errorLabelHorizontalSpacing)
            ])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.errorLabel.alpha = .zero
            strongSelf.errorLabel.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                strongSelf.errorLabel.alpha = Constants.one
            }
        }
    }
}

//MARK: - Selectors
private extension HomeViewController {
    @objc func startButtonTapped() {
        if view.contains(errorLabel) {
            errorLabel.isHidden = true
        }
        viewModel.startQuiz()
    }
}
