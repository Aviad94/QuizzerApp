//
//  QuizBrain.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//

import Foundation
import UIKit

protocol updateArrays {
    func updateQuestionsArray(questionsArr: [Question])


}

struct QuizBrain {
   
    let urlString = "https://5fa952f1c9b4e90016e6a5be.mockapi.io/data"
    
    
    var updateDelegate: updateArrays? // ??
    
     func performRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error != nil {
                    print("There's an error \(error)")
                }
                if let safeData = data {
                    self.parseJSON(with: safeData)
                    
                }
            }
            task.resume()
        }
    }
    
    
    
     func parseJSON(with data: Data)  {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Root.self, from: data)
            
            //DIC
//            var quiz = [decodedData.data.questions[0].question: decodedData.data.questions[0].options[1].value,
//                        decodedData.data.questions[1].question: decodedData.data.questions[1].options[0].value
//            ]
            
            //Array
            let quiz = [
                Question(q: decodedData.data.questions[0].question, a: decodedData.data.questions[0].options[1].value,o: decodedData.data.questions[0].options),
                Question(q: decodedData.data.questions[1].question, a: decodedData.data.questions[1].options[0].value, o: decodedData.data.questions[1].options),
                Question(q: decodedData.data.questions[2].question, a: decodedData.data.questions[2].options[1].value, o: decodedData.data.questions[2].options)
                ]
            

            self.updateDelegate?.updateQuestionsArray(questionsArr: quiz)

            
        } catch {
            print("There was a problem with parsing JSON \(error)")
        }
    }
    
    
    
//    func getQuestionText() -> String {
//        return totalQuestions[questionNumber].text
//    }
//
    
    

    
     func nextQuestion(questionNum: Int, numOfQuestions: Int) -> Int {
       if questionNum + 1 < numOfQuestions {
        return questionNum + 1
       } else {
        return 0
       }
   }
    
    
    
    
    func getScore(scoreNum: Int) ->Int {
        return scoreNum+5
    }
 
    
    
    func checkAnswer(userAnswer: String, correctAnswer: String) -> Bool {
        if userAnswer == correctAnswer {
            return true
        } else {
            return false
        }
    }
    
    
    
    

    
}
