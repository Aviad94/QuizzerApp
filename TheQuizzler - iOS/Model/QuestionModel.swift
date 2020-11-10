//
//  Data.swift
//  TheQuizzler - iOS
//
//  Created by Aviad Sabag on 09/11/2020.
//


import Foundation

struct Root: Decodable { // data
    let data : DataInfo
    
}

struct DataInfo : Codable { // data structure
    
    let name: String
    let game_id: String
    let points: Int
    let thank_you_message: String
    let questions: [Questions]

    
    
}


struct Questions : Codable { // Question structure
//    let question_id: String
    let question: String
//    let question_url: String
//    let question_type: String
    let options: [Options]
    
    
}


struct Options : Codable { // Options structure
    let option_id: Int
    let value: String
    let option_type: String
}
