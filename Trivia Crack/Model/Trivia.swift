//
//  Trivia.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/8/21.
//

import Foundation

/// A type to handle the data from the API request. 
public struct Trivia: Codable {
    var results: [Result]
}
