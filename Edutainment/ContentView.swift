//
//  ContentView.swift
//  Edutainment
//
//  Created by sebastian.popa on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    let difficulties: [Difficulty] = [.Easy, .Medium, .Hard]
    let rangeOfMultiplicationTable = 2...10
        
    @State private var selectedMultiplicationTable = 5
    @State private var selectedNumberOfRounds = 10
    @State private var selectedDifficulty: Difficulty = .Medium
    
    @State private var rangeOfMultiplicationValues = 1...100
    
    var possibleNumberOfRounds: [Int] {
        selectedDifficulty == .Easy ? [5, 10] : [5, 10, 15, 20]
    }
    
    @State private var questions = [Int]()
    @State private var isGameStarted = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.red, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Text("Multiplication tables!")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    HStack {
                        Section {
                            Picker("", selection: $selectedMultiplicationTable) {
                                ForEach(rangeOfMultiplicationTable, id: \.self) {
                                    Text("\($0)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 50, height: 150)
                        } header: {
                            Text("Which multiplication table do you want to practice?")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    HStack {
                        Section {
                            Picker("", selection: $selectedNumberOfRounds) {
                                ForEach(possibleNumberOfRounds, id: \.self) {
                                    Text("\($0)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 50, height: 150)
                        } header: {
                            Text("How many rounds do you want?")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    HStack {
                        Section {
                            Picker("", selection: $selectedDifficulty) {
                                ForEach(difficulties, id: \.self) {
                                    Text("\($0.rawValue)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 150, height: 150)
                        } header: {
                            Text("Select the difficulty")
                                .font(.title2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Spacer()
                    Button("Start"){
                        startGame()
                        isGameStarted = true
                    }
                    .frame(width: 150, height: 50)
                    .background(Gradient(colors: [.green, .yellow]))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding(10)
            }
            .navigationBarBackButtonHidden(true)
            .foregroundColor(.white)
            .navigationDestination(isPresented: $isGameStarted) {
                GameView(selectedMultiplicationTable: selectedMultiplicationTable, questions: questions)
            }
        }
    }
    
    func startGame() {
        switch selectedDifficulty {
        case .Easy:
            rangeOfMultiplicationValues = 1...10
        case .Medium:
            rangeOfMultiplicationValues = 1...100
        case .Hard:
            rangeOfMultiplicationValues = 1...1000
        }
        
        questions = [Int](rangeOfMultiplicationValues.shuffled().prefix(upTo: selectedNumberOfRounds))
        
        isGameStarted = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
