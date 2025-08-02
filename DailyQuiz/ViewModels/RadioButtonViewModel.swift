//
//  RadioButtonViewModel.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 2.08.25.
//

import UIKit

final class RadioButtonViewModel {
    
    //MARK: - Properties
    
    private(set) var title: String
    private(set) var isSelected: Bool = false
    
    //MARK: - Closures
    
    var onSelectionChanged: ((Bool) -> Void)?
    
    //MARK: - Constants
    
    private enum Constants {
        static let viewBorderWidth: CGFloat = 1
    }
    
    //MARK: - Init
    
    init(title: String = "") {
        self.title = title
    }
    
    func setSelected(_ selected: Bool) {
        let wasSelected = isSelected
        isSelected = selected
        
        if wasSelected != isSelected {
            onSelectionChanged?(isSelected)
        }
    }
    
    func toggle() {
        setSelected(!isSelected)
    }
    
    //MARK: - UI Configuration Methods
    
    func getBackgroundColor() -> UIColor? {
        return isSelected ? UIColor(named: "selectedColor") : .clear
    }
    
    func getBorderColor() -> CGColor? {
        return isSelected ? UIColor(named: "selectedColor")?.cgColor : UIColor.black.cgColor
    }
    
    func getImage() -> UIImage? {
        return isSelected ? UIImage(named: "selectedAnswerIcon") : nil
    }
    
    func getTintColor() -> UIColor {
        return isSelected ? .white : .clear
    }
    
    func getViewBorderWidth() -> CGFloat {
        return isSelected ? Constants.viewBorderWidth : .zero
    }
    
    func getViewBorderColor() -> CGColor? {
        return isSelected ? UIColor(named: "selectedColor")?.cgColor : UIColor.clear.cgColor
    }
}
