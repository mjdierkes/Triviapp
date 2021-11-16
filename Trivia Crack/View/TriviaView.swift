//
//  TriviaView.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/13/21.
//

import SwiftUI

struct TriviaView: View {
    
    @ObservedObject var manager = TriviaManager()
    @State private var current = 0
    @State private var status: Status = .undetermined
    @State private var selected: String = ""
    @State private var timeRemaining = 100.0
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .center){
            
            CategoryHeader()
            
            if status != .undetermined {
                ProgressView("", value: timeRemaining, total: 100)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 2
                        }
                        else {
                            timeRemaining = 100.0
                            status = .undetermined
                            manager.nextQuestion()
                        }
                    }
            }
            
            Text(manager.current?.question ?? "Unable to connect to the internet.")
                .font(.title2).bold()
                .multilineTextAlignment(.center)
                .padding()
                 

            
            ForEach(manager.answers, id: \.self){ answer in
                AnswerChoice(status: $status, answer: answer)
                    .disabled(status != .undetermined)
            }
            
            Text(manager.correctAnswer)
            Spacer()
            Rectangle()
                .foregroundColor(Color.white)
                .onTapGesture {
                    if(status != .undetermined){
                        timeRemaining = 0
                    }
                }

        }
        .environmentObject(manager)
        

    }
}

public enum Status {
    case undetermined, correct, incorrect
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
