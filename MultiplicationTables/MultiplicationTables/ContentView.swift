//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by MIsono on 2019/11/18.
//  Copyright © 2019 misono. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var maxRow = 1
    @State private var questionIndex = 3
    @State private var showingSettings = true
    @State private var showingMessage = false
    @State private var showingScore = false
    @State private var totalScore = 0

    @State private var quiz: Quiz? {
        didSet {
            guard let currentQuiz = quiz, let(row, col) = currentQuiz.questions.first else { return }
            
            currentRow = row
            currentCol = col
        }
    }
    @State private var currentRow = 1
    @State private var currentCol = 1
    @State private var increment = 0 {
        didSet {
            guard let questions = quiz?.questions, increment > 0 else { return }
            if increment < questions.count, let(row, col) = quiz?.questions[increment] {
                currentRow = row
                currentCol = col
            } else {
                showingScore = true
            }
            
            
        }
    }
    @State private var input = ""

    let questions = ["5", "10", "20", "All"]


    var body: some View {

        NavigationView {
            Form {
                if showingSettings {
                    Group {
                        VStack(alignment: .leading, spacing: 0) {
                            Stepper(value: $maxRow, in: 1...12) {
                                if maxRow == 1 {
                                    Text("Row is \(self.maxRow, specifier: "%i")")
                                } else {
                                    Text("Up to… \(self.maxRow, specifier: "%i")")
                                }
                            }
                            HStack {
                                Text("How many questions?")
                                Picker("", selection: $questionIndex) {
                                    ForEach(0..<questions.count) {
                                        Text("\(self.questions[$0])")
                                    }
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        // FIXME: Add Charactors later on.
                        //                Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

                        //                Spacer()

                        //                Button("Tap Me") {
                        //                    self.animationAmount += 1
                        //                }
                        //                .padding(40)
                        //                .background(Color.red)
                        //                .foregroundColor(.white)
                        //                .clipShape(Circle())
                        //                .scaleEffect(animationAmount)

                    }
                }
                
                Group {


                    if showingSettings {
                        Button("I'm Ready!") {
                            let totalCount: Int
                            if self.questionIndex == 3 {
                                totalCount = 0
                            } else {
                                totalCount = Int(self.questions[self.questionIndex]) ?? 0
                            }
                            self.quiz = Quiz(maxRow: self.maxRow, totalNumber: totalCount)

                            withAnimation {
                                self.showingSettings.toggle()
                            }
                        }
                    } else {
                        VStack {
                            Text("\(currentRow) x \(currentCol) = \(input.isEmpty ? "?" : input)").font(.largeTitle)
                            TextField("Enter your Answer", text: $input, onCommit: calc)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                                .keyboardType(.numbersAndPunctuation)
                                .transition(.scale)
                            }
                    }
                }
                
            }.navigationBarTitle("MultiplicationTables")
            .alert(isPresented: $showingScore) {
                Alert(title: Text("Finish!!"), message: Text("Your score is " + String(totalScore) + " /" + self.questions[self.questionIndex] ), dismissButton: .default(Text("Restart")) { self.startGame() })
            }
        }
    }

    func startGame() {
        maxRow = 1
        questionIndex = 3
        showingSettings = true
        showingMessage = false
        showingScore = false
        totalScore = 0
        quiz = nil
        input = ""
        increment = 0
    }

    func calc() {
        if let answer = Int(input), answer == currentRow * currentCol {
            totalScore += 1
        }

        guard let totalNumber = quiz?.questions.count else { return }
        
        if increment < totalNumber {
            increment += 1
        }
        
        input = ""
    }

}

/*
 Challenge:
- The player needs to select which multiplication tables they want to practice.
 This could be pressing buttons, or it could be an “Up to…” stepper, going from 1 to 12.
- The player should be able to select how many questions they want to be asked: 5, 10, 20, or “All”.
- You should randomly generate as many questions as they asked for, within the difficulty range they asked for. For the “all” case you should generate all possible combinations.
 */
struct Quiz {
    let columns: [Int] = Array(1...12)
    let rows: [Int]
    let questions: [(Int, Int)]

    init(maxRow: Int, totalNumber: Int) {
        self.rows = Array(1...maxRow)
        self.questions = generate(with: rows, columns: columns, totalNumber: totalNumber)
    }
}

private func generate(with rows: [Int], columns: [Int], totalNumber: Int) -> [(Int, Int)] {
    let numbers = rows.flatMap { row in
       return columns.map { (row, $0) }
    }.shuffled()

    return totalNumber > 0 ? Array(numbers.prefix(totalNumber)) : numbers
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
