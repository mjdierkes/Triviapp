//
//  TriviaManager.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/8/21.
//

import Foundation
import SwiftUI

public class TriviaManager: ObservableObject{
        
    @Published public var current: Result?
    @Published public var answers: [String] = [String]()
    @Published public var correctAnswer: String = ""
    @Published public var score = 0
    @Published public var currentTime = 100
    
    private var streak = 1
    private var trivia: Trivia
    private var question = 0
    
    public init(){
        trivia = Trivia(results: [Result]())
        loadData()
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.currentTime -= 10
        }
    }
    
    public func reload(){
        loadData()
    }
    
    public func nextQuestion(){
        if (question == trivia.results.count - 1){
            question = 0
            reload()
        }
        else {
            question += 1
        }
        current = trivia.results[question]
        correctAnswer = trivia.results[question].correct_answer
        shuffleAnswers()
    }
    
    public func updateScore(with answer: String) -> Status {
        if(answer == correctAnswer){
            streak += 1
            score += currentTime * streak
            return .correct
        }
        else {
            streak = 1
            return .incorrect
        }
    }
    
    private func shuffleAnswers(){
        if var current = current {
            current.incorrect_answers.append(current.correct_answer)
            answers = current.incorrect_answers.shuffled()
        }
    }
        
    private func loadData(){
        if let url = URL(string: "https://opentdb.com/api.php?amount=10") {
            do {
                let JSON = try String(contentsOf: url)
                let jsonData = JSON.data(using: .utf8)!
                trivia = try! JSONDecoder().decode(Trivia.self, from: jsonData)
                current = trivia.results[0]
                correctAnswer = trivia.results[0].correct_answer
                shuffleAnswers()
            } catch {
                print("Contents could not be loaded")
            }
        }
    }
    
    private func generateURL(from options: Options) -> String {
        return "https://opentdb.com/api.php?amount=\(options.questions)&category=21&difficulty=\(options.difficulty)&type=\(options.type)"
    }
        
}

extension String {
    var decoded: String {
        let attr = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)

        return attr?.string ?? self
    }
}

