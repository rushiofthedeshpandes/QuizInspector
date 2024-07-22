//
//  QuestionaireViewController.swift
//  QuizInspector
//
//  Created by Rushikesh Deshpande on 20/07/24.
//

import UIKit

protocol DataUpdater{
    func didUpdateQuestions(_ questions: [Question]?, for category: Category)
}

class QuestionaireViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var verticalStackView: UIStackView!
    var delegate : DataUpdater?
    var category : Category?
    var questions: [Question] = []
    var completedQuestions : [Question] = []
    var inspectionBrain : InspectionBrain = InspectionBrain([])

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inspectionBrain.questions = questions
        completedQuestions = []
        updateUI()
    }
    
    @objc func pressed(_ sender: UIButton) {
        let answerChoice = inspectionBrain.getAnswerChoices()[sender.tag]
        inspectionBrain.checkAnswer(answerChoice)
        if let completedQuestion =  inspectionBrain.getCurrentQuestion(){
            completedQuestions.append(completedQuestion)
        }
        sender.backgroundColor = .green
        if inspectionBrain.isNextQuestionAvailable(){
            inspectionBrain.nextQuestion()
            Timer.scheduledTimer(timeInterval: 0.2, 
                                 target: self,
                                 selector: #selector(updateUI), 
                                 userInfo: nil, repeats: false)
        }else{
            updateProgress()
            showAlert(K.surveyCompleted, K.selectNextCategory ){
                if let updatedCategory = self.category {
                    let newCategory = Category(id: updatedCategory.id,
                                               name: updatedCategory.name,
                                               questions: self.completedQuestions)
                    self.delegate?.didUpdateQuestions(self.completedQuestions, for: newCategory)
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateProgress(){
        progressBar.progress = inspectionBrain.getProgress()
        scoreLabel.text = "Score : \(inspectionBrain.getScore())"
    }
    
    @objc func updateUI(){
        updateProgress()
        questionLabel.text = inspectionBrain.getQuestionText()
        displayChoices()
    }
    
    fileprivate func removeStackSubViews() {
        if verticalStackView.subviews.count > 0 {
            for view in verticalStackView.subviews{
                verticalStackView.removeArrangedSubview(view)
            }
        }
    }
    
    fileprivate func displayChoices() {
        removeStackSubViews()
        var tag = 0
        for answerChoice in inspectionBrain.getAnswerChoices(){
            print(answerChoice)
            let optionButton = UIButton()
            optionButton.setTitle(answerChoice.name, for: .normal)
            optionButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
            optionButton.setTitleColor(.white, for: .normal)
            optionButton.backgroundColor = .clear
            optionButton.frame = CGRect(x: 15, y:50 , width: 300, height: 50)
            optionButton.tag = tag
            optionButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
            optionButton.layer.cornerRadius = 10
            optionButton.layer.borderWidth = 1.0
            optionButton.layer.borderColor = UIColor.white.cgColor
            verticalStackView.addArrangedSubview(optionButton)
            tag += 1
        }
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillProportionally
        verticalStackView.spacing = 8.0
    }
    
}
