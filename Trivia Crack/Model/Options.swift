//
//  Options.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/10/21.
//

import Foundation


public struct Options {
    let questions: Int
    let category: Category
    let difficulty: Difficulty
    let type: Mode
}


public enum Category: String, Decodable {
    case art, sports, history
}

public enum Difficulty: String, Decodable {
    case easy, medium, hard
}

public enum Mode: String, Decodable {
    case any, multiple, boolean
}

