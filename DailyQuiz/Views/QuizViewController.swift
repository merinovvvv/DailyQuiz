//
//  QuizViewController.swift
//  DailyQuiz
//
//  Created by Yaroslav Merinov on 1.08.25.
//

import UIKit

final class QuizViewController: UIViewController {
    
    private var tasks: [Task]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "lilac")
    }

    init(tasks: [Task]) {
        self.tasks = tasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
