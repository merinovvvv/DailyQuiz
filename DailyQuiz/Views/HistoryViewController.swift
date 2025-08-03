//
//  HistoryViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 3.08.25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    //MARK: - Variables
    private let viewModel: HistoryViewModel
    
    //MARK: - Constants
    
    private enum Constants {
        
        //MARK: Constraints
        
        static let titleLabelTopSpacing: CGFloat = 32
        
        static let emptyStateViewTopSpacing: CGFloat = 40
        static let emptyStateViewHorizontalSpacing: CGFloat = 16
        
        static let emptyStateLabelTopSpacing: CGFloat = 32
        static let emptyStateLabelHorizontalSpacing: CGFloat = 32
        
        static let startQuizButtonTopSpacing: CGFloat = 40
        static let startQuizButtonHorizontalSpacing: CGFloat = 40
        static let startQuizButtonBottomSpacing: CGFloat = 32
        static let startQuizButtonHeightMultiplier: CGFloat = 50/280
        
        static let tableViewTopSpacing: CGFloat = 40
        static let tableViewHorizontalSpacing: CGFloat = 26
        static let tableViewBottomSpacing: CGFloat = 40
        
        static let dailyQuizImageViewBottomSpacing: CGFloat = 76
        static let dailyQuizImageViewHorizontalSpacing: CGFloat = 106
        static let dailyQuizImageViewHeightMultipler: CGFloat = 40/180
        
        static let backButtonLeadingSpacing: CGFloat = 26
        static let backButtonSize: CGFloat = 24
        
        
        //MARK: - Values
        
        static let titleLabelFontSize: CGFloat = 32
        
        static let emptyStateViewCornerRadius: CGFloat = 46
        
        static let emptyStateLabelFontSize: CGFloat = 20
        
        static let startButtonTextFontSize: CGFloat = 16
        static let startButtonCornerRadius: CGFloat = 16
        
        static let one: CGFloat = 1
        
    }
    
    //MARK: - UI Components
    
    private let titleLabel: UILabel = UILabel()
    
    private let emptyStateView: UIView = UIView()
    private let emptyStateLabel: UILabel = UILabel()
    private let startQuizButton: UIButton = UIButton(type: .system)
    
    private let tableView: UITableView = UITableView()
    
    private let dailyQuizImageView: UIImageView = UIImageView()
    
    private let backButton: UIButton = UIButton(type: .system)
    
    //MARK: - Init
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        
        viewModel.loadHistory()
        
        emptyStateView.alpha = .zero
        tableView.alpha = .zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut) {
            self.emptyStateView.alpha = Constants.one
            self.tableView.alpha = Constants.one
        } completion: { _ in
            self.updateScrollability()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollability()
    }
    
    //MARK: - Private Methods
    
    private func updateUIForCurrentState() {
        let isEmpty = viewModel.isEmpty
        
        emptyStateView.isHidden = !isEmpty
        dailyQuizImageView.isHidden = !isEmpty
        tableView.isHidden = isEmpty
        
        if !isEmpty {
            tableView.reloadData()
            DispatchQueue.main.async {
                self.updateScrollability()
            }
        }
    }
    
    //MARK: - Setup Bindings
    private func setupBindings() {
        
        viewModel.onStartQuiz = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        viewModel.onHistoryUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUIForCurrentState()
            }
        }
    }
}

//MARK: - Setup UI
private extension HistoryViewController {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func setupViewHierarchy() {
        view.addSubview(titleLabel)
        
        view.addSubview(emptyStateView)
        emptyStateView.addSubview(emptyStateLabel)
        emptyStateView.addSubview(startQuizButton)
        
        view.addSubview(tableView)
        view.addSubview(dailyQuizImageView)
        view.addSubview(backButton)
    }
    
    func setupConstraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        startQuizButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        dailyQuizImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleLabelTopSpacing),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.backButtonLeadingSpacing),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonSize),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.emptyStateViewTopSpacing),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.emptyStateViewHorizontalSpacing),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.emptyStateViewHorizontalSpacing),
            
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateView.topAnchor, constant: Constants.emptyStateLabelTopSpacing),
            emptyStateLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: Constants.emptyStateLabelHorizontalSpacing),
            emptyStateLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -Constants.emptyStateLabelHorizontalSpacing),
            
            startQuizButton.topAnchor.constraint(equalTo: emptyStateLabel.bottomAnchor, constant: Constants.startQuizButtonTopSpacing),
            startQuizButton.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: Constants.startQuizButtonHorizontalSpacing),
            startQuizButton.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -Constants.startQuizButtonHorizontalSpacing),
            startQuizButton.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor, constant: -Constants.startQuizButtonBottomSpacing),
            startQuizButton.heightAnchor.constraint(equalTo: startQuizButton.widthAnchor, multiplier: Constants.startQuizButtonHeightMultiplier),
            
            dailyQuizImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.dailyQuizImageViewBottomSpacing),
            dailyQuizImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.dailyQuizImageViewHorizontalSpacing),
            dailyQuizImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.dailyQuizImageViewHorizontalSpacing),
            dailyQuizImageView.heightAnchor.constraint(equalTo: dailyQuizImageView.widthAnchor, multiplier: Constants.dailyQuizImageViewHeightMultipler),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.tableViewTopSpacing),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewHorizontalSpacing),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableViewHorizontalSpacing),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureViews() {
        
        backButton.setImage(UIImage(named: "leftIcon"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.contentHorizontalAlignment = .fill
        backButton.contentVerticalAlignment = .fill
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        titleLabel.text = "История"
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .black)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        emptyStateView.backgroundColor = .white
        emptyStateView.layer.cornerRadius = Constants.emptyStateViewCornerRadius
        emptyStateView.clipsToBounds = true
        
        emptyStateLabel.text = "Вы еще не проходили \nни одной викторины"
        emptyStateLabel.numberOfLines = .zero
        emptyStateLabel.font = UIFont.systemFont(ofSize: Constants.emptyStateLabelFontSize, weight: .regular)
        emptyStateLabel.textColor = .black
        emptyStateLabel.textAlignment = .center
        
        startQuizButton.setTitle("начать викторину".uppercased(), for: .normal)
        startQuizButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.startButtonTextFontSize, weight: .black)
        startQuizButton.layer.cornerRadius = Constants.startButtonCornerRadius
        startQuizButton.backgroundColor = UIColor(named: "lilac")
        startQuizButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startQuizButton.tintColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        dailyQuizImageView.image = UIImage(named: "dailyQuizLogo")
        dailyQuizImageView.contentMode = .scaleAspectFit
    }
}

//MARK: - TableView
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as? HistoryTableViewCell,
           let historyItem = viewModel.getHistoryItem(at: indexPath.row) {
            let title = viewModel.getQuizTitle(for: indexPath.row)
            let date = viewModel.getFormattedDate(for: historyItem)
            let time = viewModel.getFormattedTime(for: historyItem)
            
            cell.configure(
                title: title,
                date: date,
                time: time,
                correctAnswers: historyItem.correctAnswers,
                totalQuestions: historyItem.totalQuestions
            )
            
            return cell
        }
        
        
        return UITableViewCell()
    }
}

//MARK: - Selectors
private extension HistoryViewController {
    @objc func startButtonTapped() {
        viewModel.startNewQuiz()
    }
}

extension HistoryViewController {
    private func updateScrollability() {
        let contentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.bounds.height - tableView.contentInset.top - tableView.contentInset.bottom
        
        tableView.isScrollEnabled = contentHeight > tableViewHeight
    }
}
