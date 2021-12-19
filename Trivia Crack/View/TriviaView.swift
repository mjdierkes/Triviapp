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
    @State private var waiting = false
    

    var body: some View {
        VStack(alignment: .center){
            
            CategoryHeader(status: $status, timeRemaining: $timeRemaining, waiting: $waiting)
            
            Spacer()
            
            Text(manager.current?.question ?? "Unable to connect to the internet.")
                .font(.title2).bold()
                .multilineTextAlignment(.center)
                .padding()
                 
            Spacer()
            
            ForEach(manager.answers, id: \.self){ answer in
                AnswerChoice(status: $status, answer: answer)
                    .disabled(status != .undetermined)
            }
            
            Rectangle()
                .foregroundColor(Color.white)
                .frame(maxHeight: 60)
                .onTapGesture {
                    if(status != .undetermined){
                        timeRemaining = 0
                    }
                }
                .onLongPressGesture(minimumDuration: .infinity, pressing: { inProgress in
                    waiting = inProgress
                   }) {
                       print("Long pressed!")
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
