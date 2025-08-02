//
//  RadioButtonView.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 2.08.25.
//

import UIKit

final class RadioButtonView: UIView {
    
    //MARK: - Variables
    var viewModel: RadioButtonViewModel
    
    var onTap: (() -> Void)?
    
    //MARK: - Init
    init(title: String) {
        self.viewModel = RadioButtonViewModel(title: title)
        super.init(frame: .zero)
        setupBindings()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radioButton.layer.cornerRadius = radioButton.bounds.height / 2
    }
    
    //MARK: - Constants
    private enum Constants {
        
        //MARK: - Constraints
        
        static let radioButtonSpacing: CGFloat = 16
        
        static let titleLabelVerticalSpacing: CGFloat = 18
        static let titleLabelLeadingSpacing: CGFloat = 16
        static let titleLabelTrailingSpacing: CGFloat = 185
        
        
        //MARK: - Values
        
        static let viewCornerRadius: CGFloat = 16
        
        static let titleLabelFontSize: CGFloat = 14
        
        static let radioButtonBorderWidth: CGFloat = 1
        static let radioButtonSize: CGFloat = 20
        
        static let selectedViewBorderWidth: CGFloat = 1
    }
    
    //MARK: - UI Components
    
    private let radioButton = UIButton(type: .system)
    
    private let titleLabel = UILabel()
    
    private let tapGesture = UITapGestureRecognizer()
    
    //MARK: - Methods
    
    private func setupBindings() {
        viewModel.onSelectionChanged = { [weak self] isSelected in
            DispatchQueue.main.async {
                self?.updateAppearance()
            }
        }
    }
    
    private func updateAppearance() {
        radioButton.backgroundColor = viewModel.getBackgroundColor()
        radioButton.layer.borderColor = viewModel.getBorderColor()
        radioButton.setImage(viewModel.getImage(), for: .normal)
        radioButton.tintColor = viewModel.getTintColor()
        
        self.layer.borderWidth = viewModel.getViewBorderWidth()
        self.layer.borderColor = viewModel.getViewBorderColor()
    }
}

//MARK: - Setup UI
private extension RadioButtonView {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
        updateAppearance()
    }
    
    func setupViewHierarchy() {
        self.addSubview(radioButton)
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.radioButtonSpacing),
            radioButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.radioButtonSpacing),
            radioButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.radioButtonSpacing),
            radioButton.widthAnchor.constraint(equalToConstant: Constants.radioButtonSize),
            radioButton.heightAnchor.constraint(equalToConstant: Constants.radioButtonSize),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: Constants.titleLabelLeadingSpacing),
        ])
    }
    
    func configureViews() {
        self.layer.cornerRadius = Constants.viewCornerRadius
        self.backgroundColor = UIColor(named: "answerViewColor")
        
        titleLabel.text = viewModel.title
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .regular)
        titleLabel.numberOfLines = .zero
        
        radioButton.layer.borderWidth = Constants.radioButtonBorderWidth
        radioButton.imageView?.contentMode = .scaleAspectFit
        
        tapGesture.addTarget(self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        
        radioButton.addTarget(self, action: #selector(viewTapped), for: .touchUpInside)
    }
}

//MARK: - Selectors
private extension RadioButtonView {
    @objc private func viewTapped() {
        onTap?()
    }
}
