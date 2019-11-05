//
//  ContentView.swift
//  BrainGame
//
//  Created on 2019/10/31.
//  Copyright © 2019 misono. All rights reserved.
//
//  Challenge: https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge
//  Summary: https://www.hackingwithswift.com/100/swiftui/25

import SwiftUI

struct ContentView: View {
    let choices = ["ready", "rock", "paper", "scissors"]
    @State private var scoreTitle = "Make Win!!"
    @State private var shouldWin = true {
        didSet {
            scoreTitle = shouldWin ? "Make Win!!" : "Make Lose!!"
        }
    }
    @State private var showingScore = false
    @State private var result = ""
    @State private var randomSelect = 0
    @State private var totalScore = 0
    @State private var decrement = 10 {
        didSet {
            guard decrement == 0 else { return }

            randomSelect = 0
            totalScore = 0
            decrement = 10
        }
    }

    var body: some View {

        ZStack {
            VStack(spacing: 10) {
                Text("You should ...\(scoreTitle)")
                Image(choices[randomSelect])
                    .resizable()
                    .frame(width:200, height: 200, alignment: .center)

                Text("Tap your choice!")

                HStack(spacing: 20) {
                    ForEach(1 ..< choices.count) { number in
                        Button(action: {
                            self.tapped(number)
                        }) {
                            GameImage(hand: self.choices[number])
                        }
                        .foregroundColor(Color.black)
                    }
                }
            }

        }.alert(isPresented: $showingScore) {
            return makeAlert(decrement: decrement, resultMessage: result, totalScore: String(totalScore), scoreTitle: scoreTitle)
        }

    }

    func tapped(_ number: Int) {
        randomSelect = Int.random(in: 1 ..< choices.count)
        result = getMessage(from: choices[number], randomSelected: choices[randomSelect])
        showingScore = true
    }

    func makeAlert(decrement: Int, resultMessage: String, totalScore: String, scoreTitle: String) -> Alert {
        let title: String
        let message: String
        let dismissButtonTitle: String
        if decrement == 0 {
            title = "Game Over!"
            message = "Your total score is " + totalScore
            dismissButtonTitle = "Reset"
        } else {
            title = scoreTitle
            message = "You are .." + resultMessage
            dismissButtonTitle = "Continue"
        }
        return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text(dismissButtonTitle)) {
            self.askQuestion()
        })
    }

    func askQuestion() {
        shouldWin  = Bool.random()
        decrement -= 1
    }

    func getMessage(from usersChoice: String, randomSelected: String) -> String {
        switch (usersChoice, randomSelected) {
        case ("rock", "scissors"), ("paper", "rock"), ("scissors", "paper"):
            totalScore += shouldWin ? 1 : -2
            return shouldWin ? "WIN❤️" : "LOSE💔You should've \(scoreTitle)"
        case ("rock", "paper"), ("paper", "scissors"), ("scissors", "rock"):
            totalScore += shouldWin ? -1 : 2
            return shouldWin ?  "LOSE💔You should've \(scoreTitle)" : "WIN❤️"
        default:
            return "draw, actuallry"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameImage: View {
    var hand: String
    var body: some View {
        Image(hand)
        .resizable()
        .frame(width: 70, height: 70)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 0.5))
    }
}
