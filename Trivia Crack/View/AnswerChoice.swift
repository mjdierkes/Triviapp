//
//  AnswerChoice.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/13/21.
//

import SwiftUI

struct AnswerChoice: View {
    
    @EnvironmentObject var manager: TriviaManager
    @Binding var status: Status
    @State private var selected: String = ""
    
    public var answer: String
    
    var body: some View {
        Button {
            selected = answer
            status = manager.updateScore(with: answer)
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 350, height: 40)
                    .foregroundColor(colorStatus())
                Text(answer)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
    
    private func colorStatus() -> Color{
        
        if (status == .correct || status == .incorrect ) && answer == manager.correctAnswer {
            return Color.green
        }
        else if (status == .incorrect && answer == selected) {
            return Color.red
        }
        else if status != .undetermined {
            return Color.gray
        }
        
        return Color.blue
    }
}

struct AnswerChoice_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
