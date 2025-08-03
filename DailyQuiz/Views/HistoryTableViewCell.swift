//
//  HistoryTableViewCell.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 3.08.25.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier: String = "HistoryTableViewCell"
    
    //MARK: - Constants
    
    private enum Constants {
        
        //MARK: - Constraints
        
        static let containerStackViewSpacing: CGFloat = 24
        
        static let dateStackViewTopSpacing: CGFloat = 12
        
        static let starsStackViewHorizontalSpacing: CGFloat = 6
        
        //MARK: - Values
        
        static let containerViewCornerRadius: CGFloat = 40
        
        static let titleLabelFontSize: CGFloat = 24
        
        static let dateLabelFontSize: CGFloat = 12
        
        static let timeLabelFontSize: CGFloat = 12
        
        static let starImageSize: CGFloat = 16
        
        static let containerStackViewContentSpacing: CGFloat = 12
        
        static let cellVerticalSpacing: CGFloat = 24
        
    }
    
    //MARK: - UI Properties
    
    private let containerView: UIView = UIView()
    private let containerStackView: UIStackView = UIStackView()
    
    private let titleStackView: UIStackView = UIStackView()
    private let titleLabel: UILabel = UILabel()
    private let starsStackView: UIStackView = UIStackView()

    private let dateStackView: UIStackView = UIStackView()
    private let dateLabel: UILabel = UILabel()
    private let timeLabel: UILabel = UILabel()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
    override func setSelected(_ highlighted: Bool, animated: Bool) { }
    
    func configure(
        title: String,
        date: String,
        time: String,
        correctAnswers: Int,
        totalQuestions: Int
    ) {
        titleLabel.text = title
        dateLabel.text = date
        timeLabel.text = time
        
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        
        for i in 0..<totalQuestions {
            let starImageView = UIImageView()
            starImageView.image = UIImage(named: "starIcon")?.withRenderingMode(.alwaysTemplate)
            starImageView.contentMode = .scaleAspectFit
            
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                starImageView.widthAnchor.constraint(equalToConstant: Constants.starImageSize),
                starImageView.heightAnchor.constraint(equalToConstant: Constants.starImageSize)
            ])
            
            if i < correctAnswers {
                starImageView.tintColor = UIColor(named: "starYellow")
            } else {
                starImageView.tintColor = UIColor(named: "disabledColor")
            }
            
            starsStackView.addArrangedSubview(starImageView)
        }
    }
}

//MARK: - Setup UI
private extension HistoryTableViewCell {
    func setupUI() {
        setupViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(dateStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(starsStackView)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(timeLabel)
    }
    
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.cellVerticalSpacing),
            
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.containerStackViewSpacing),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.containerStackViewSpacing),
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.containerStackViewSpacing),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.containerStackViewSpacing),
            
            titleStackView.topAnchor.constraint(equalTo: containerStackView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            
            starsStackView.topAnchor.constraint(equalTo: titleStackView.topAnchor, constant: Constants.starsStackViewHorizontalSpacing),
            starsStackView.bottomAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: -Constants.starsStackViewHorizontalSpacing),
            
            dateStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            dateStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            dateStackView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor),
        ])
    }
    
    func configureViews() {
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        containerView.clipsToBounds = true
        
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = Constants.containerStackViewContentSpacing
        
        titleStackView.axis = .horizontal
        titleStackView.distribution = .fill
        titleStackView.alignment = .center
        
        titleLabel.textColor = UIColor(named: "selectedColor")
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: .bold)
        
        starsStackView.axis = .horizontal
        starsStackView.distribution = .fillEqually
        starsStackView.alignment = .center
        
        dateStackView.axis = .horizontal
        dateStackView.alignment = .center
        dateStackView.distribution = .equalSpacing
        
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: Constants.dateLabelFontSize, weight: .regular)
        
        timeLabel.textColor = .black
        timeLabel.font = UIFont.systemFont(ofSize: Constants.timeLabelFontSize, weight: .regular)
        
        
    }
}
