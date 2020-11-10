//
//  ViewController.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//

import UIKit
import Foundation

class QuizViewController: UIViewController, updateArrays {
   
    func updateQuestionsArray(questionsArr: [Question]) {
        DispatchQueue.main.async {
            self.quizArr = questionsArr
            
            self.updateUI()
        }
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOption1: UIButton!
    @IBOutlet weak var answerOption2: UIButton!
    @IBOutlet weak var answerOption3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    var scoreCounter = 0
    var numOfQuestion = 0
    var numOfOptions = 0
    var quizBrain = QuizBrain() // an instance of struct QuizBrain for following MVC.
    var thanksVC = ThanksViewController()
    
    var quizArr = [Question]() // array of Q and A
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        quizBrain.performRequest() // Calling the URLRequest.

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizBrain.updateDelegate = self
}


    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        print(quizArr.count)
        guard let userAnswer = sender.currentTitle else { return }
        
        //1)Checking if the user is right:
        let userGotItRight = quizBrain.checkAnswer(userAnswer: userAnswer, correctAnswer: quizArr[numOfQuestion].answer)

        if userGotItRight {
            sender.pulsate()
            scoreCounter = quizBrain.getScore(scoreNum: scoreCounter)
            
            if numOfQuestion + 1 < quizArr.count{
                numOfQuestion = quizBrain.nextQuestion(questionNum: numOfQuestion, numOfQuestions: quizArr.count)
            } else {
                switchScreen() // Once we finis the Quiz, we show the Thanks VC.
            }
        } else {
            sender.shake() // shakes the UIButton once the answer is wrong.
        }
        
        
        //3) Adding a timer to get the next question.
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

    }
    
    
    //TODO: updateUI:
    @objc func updateUI() {
        self.questionLabel.text = self.quizArr[numOfQuestion].text
        
        self.answerOption1.setTitle(self.quizArr[numOfQuestion].options[numOfOptions].value, for: .normal) // Updates option1
        self.answerOption2.setTitle(self.quizArr[numOfQuestion].options[numOfOptions+1].value, for: .normal) // Updates option2
        self.answerOption3.setTitle(self.quizArr[numOfQuestion].options[numOfOptions+2].value, for: .normal) // Updates option3
        numOfOptions = 0
        
        scoreLabel.text = "Score: \(scoreCounter)" // updates the score.
    }
    
    
    
    
    //a func to show an alert.
    func showAlert() {
        let alert = UIAlertController(title: "Quiz is Over!", message: "The quiz is over, thanks for taking apart!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .destructive, handler: nil))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    // a func to show the thanks VC.
    func switchScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let viewController = mainStoryboard.instantiateViewController(withIdentifier: "sbThanks") as? UIViewController {
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: false, completion: nil)
        }
    }
    
}
