//
//  Question.swift
//  TheQuizzler - iOS

//  Question Structure

//  Created by Aviad Sabag on 10/11/2020.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    let options: [Options]
    
    init(q: String, a: String, o: [Options]) {
        text = q
        answer = a
        options = o
    }
}
