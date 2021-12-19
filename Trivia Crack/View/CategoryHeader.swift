//
//  CategoryHeader.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/13/21.
//

import SwiftUI

struct CategoryHeader: View {
    
    @EnvironmentObject private var manager: TriviaManager
    @Binding var status: Status
    @Binding var timeRemaining: Double
    @Binding var waiting: Bool
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            
            HStack{
                Text(manager.current?.category ?? "")
                    .font(.title3).fontWeight(.heavy)
                    .foregroundColor(Color.white)
                Spacer()
                Text("\(manager.score)")
                    .foregroundColor(Color.white)
                    .font(.title3).fontWeight(.heavy)
            }
            
            if status != .undetermined {
                ProgressView("", value: timeRemaining, total: 100)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            if !waiting {
                                timeRemaining -= 2
                            }
                        }
                        else {
                            timeRemaining = 100.0
                            status = .undetermined
                            manager.nextQuestion()
                        }
                    }
            }
        }
       
        
        .padding()
        .background(Color.green)
    }
}

struct CategoryHeader_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
    }
}
