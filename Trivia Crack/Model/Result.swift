//
//  BlogPost.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/10/21.
//

import Foundation


/// A type to handle the data from the API request. 
public struct Result: Codable {
    public var question: String
    var category: String
    var correct_answer: String
    var incorrect_answers: [String]
    
    /// Boilerplate code that enables the struct to inherent from Codable.
    /// Creates a key value pair for each variable.
    private enum CodingKeys : String, CodingKey { case question, category, correct_answer, incorrect_answers}

    /// Custom initializer from Codable. Formates data before it is encoded.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decode(String.self, forKey: .question).decoded
        category = try container.decode(String.self, forKey: .category).replacingOccurrences(of: "Entertainment:", with: "")
        correct_answer = try container.decode(String.self, forKey: .correct_answer).decoded
        incorrect_answers = try container.decode([String].self, forKey: .incorrect_answers)

        for i in 0..<incorrect_answers.count{
            self.incorrect_answers[i] = incorrect_answers[i].decoded
        }
    }
}

