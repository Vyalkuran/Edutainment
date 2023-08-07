//
//  ResultsView.swift
//  Edutainment
//
//  Created by sebastian.popa on 8/7/23.
//

import SwiftUI

struct ResultsView: View {
    
    let multiplicationTable: Int
    let questions: [Int]
    let playerAnswers: [Int]
    let correctAnswers: [Int]
    
    var questionDetails: [(Int, Int, Int)] {
        let numberOfQuestions = questions.count == playerAnswers.count && playerAnswers.count == correctAnswers.count ? questions.count : 0
        
        var details = [(question: Int, playerAnswer: Int, correctAnswer: Int)]()
        for item in 0..<numberOfQuestions {
            details.append((questions[item], playerAnswers[item], correctAnswers[item]))
        }
        
        return details
    }
    
    @State private var isRestarted = false
    
    @Environment(\.dismiss) private var dismissView

    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    List {
                        ForEach(0..<questionDetails.count, id:\.self){ item in
                            Section {
                                VStack{
                                    HStack{
                                        Image(systemName: "\(item+1).circle")
                                        Text("\(multiplicationTable) * \(questions[item])")
                                    }
                                    .font(.largeTitle)
                                    Spacer()
                                    HStack{
                                        Text("Correct Answer")
                                        Spacer()
                                        Text("Your Answer")
                                    }
                                    .font(.title3)
                                    Spacer()
                                    HStack{
                                        Text("\(correctAnswers[item])")
                                            .foregroundColor(.green)
                                        Spacer()
                                        Text("\(playerAnswers[item])")
                                            .foregroundColor(playerAnswers[item] == correctAnswers[item] ? .green : .red)
                                    }
                                    .font(.title3)
                                }
                                .padding(10)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                Button("Restart"){
//                    isRestarted = true
                    dismissView.callAsFunction()
                }
                .foregroundColor(.red)
            }
        }
//        .navigationDestination(isPresented: $isRestarted) {
//            ContentView.init()
//        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(multiplicationTable: 10, questions: [1000, 3, 4, 5, 6, 7, 8], playerAnswers: [5, 9, 12, 50, 60, 70, 80], correctAnswers: [10000, 30, 40, 50, 60, 70, 80])
    }
}
