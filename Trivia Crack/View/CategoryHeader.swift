//
//  CategoryHeader.swift
//  Trivia Crack
//
//  Created by Mason Dierkes on 11/13/21.
//

import SwiftUI

struct CategoryHeader: View {
    
    @EnvironmentObject private var manager: TriviaManager
    
    var body: some View {
        ZStack{
            HStack{
                Spacer()
                Text("\(manager.score)")
                    .foregroundColor(Color.white)
                    .font(.title3).fontWeight(.heavy)
            }
            .padding(.horizontal)
            HStack(alignment: .center){
                Text(manager.current?.category ?? "")
                    .font(.title3).fontWeight(.heavy)
                    .foregroundColor(Color.white)
            }
        }
        .padding()
        .background(Color.green)
    }
}

struct CategoryHeader_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHeader()
    }
}
