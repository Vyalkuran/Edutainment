//
//  GameView.swift
//  Edutainment
//
//  Created by sebastian.popa on 8/6/23.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct GameView: View {
    
    let selectedMultiplicationTable: Int
    let questions: [Int]
    
    @State private var answer = ""
    
    @State private var currentQuestion = 1
    
    @State private var score = 0
    
    @State private var isInvalidInput = false
    
    @State private var isFinished = false
    
    @State private var showResults = false
    
    @State private var correctAnswers = [Int]()
    @State private var playerAnswers = [Int]()
    
    @State private var hasReturnedFromResults = false
    
    @Environment(\.dismiss) private var dismissView
    
    var body: some View {
        NavigationStack{
            ZStack {
                LinearGradient(colors: [.indigo, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack{
                    Text("Multiplication Table with \(selectedMultiplicationTable)")
                        .font(.title)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Score: ")
                            Text("\(score)")
                                .foregroundColor(.green)
                        }
                        .font(.title2)
                        HStack {
                            Text("Question")
                            Image(systemName: "\(currentQuestion).circle")
                        }
                    }
                    .font(.largeTitle)
                    
                    Spacer()
                    
                    Text("\(selectedMultiplicationTable) * \(questions[currentQuestion-1]) is")
                        .font(.largeTitle)
                    
                    Spacer()
                    
                    TextField("", text: $answer, prompt: Text("Answer here")
                        .foregroundColor(.white)
                    )
                        .font(.largeTitle)
                        .background(.ultraThinMaterial)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            self.hideKeyboard()
                        }
                        .frame(width: 200, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    Spacer()
                    Button("Submit answer"){
                        answerValidation()
                    }
                    .frame(width: 150, height: 50)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .onSubmit {
                        self.hideKeyboard()
                    }
                    .alert("Invalid input", isPresented: $isInvalidInput){
                        Button("OK", role: .cancel){
                            
                        }
                    } message: {
                        Text("You must input a number please!")
                    }
                    .alert("Quiz finished!", isPresented: $isFinished){
                        Button("Try Again", role: .cancel) {
                            dismissView.callAsFunction()
                        }
                        .foregroundColor(.green)
                        Button("See results"){
                            showResults = true
                            hasReturnedFromResults = true
                        }
                        .foregroundColor(.orange)
                    } message: {
                        Text("You scored \(score) out of \(questions.count)")
                    }
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showResults) {
            ResultsView(multiplicationTable: selectedMultiplicationTable, questions: questions, playerAnswers: playerAnswers, correctAnswers: correctAnswers)
        }
        .onAppear {
            if hasReturnedFromResults {
                hasReturnedFromResults = false
                dismissView.callAsFunction()
            }
        }
    }
    
    func answerValidation(){
        guard let answerValue = Int(answer) else {
            isInvalidInput = true
            return
        }
        let correctAnswer = selectedMultiplicationTable * questions[currentQuestion-1]
        if correctAnswer == answerValue {
            score += 1
        }
        answer = ""
        playerAnswers.append(answerValue)
        correctAnswers.append(correctAnswer)
        if (currentQuestion == questions.count){
            isFinished = true
            return
        }
        currentQuestion += 1
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(selectedMultiplicationTable: 5, questions: [13, 10, 2, 1])
    }
}
