//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chris Arnoult on 11/28/19.
//  Copyright © 2019 Chris Arnoult. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var flagTappedNow = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 200) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    ForEach(0 ..< 3) {
                        number in Button(action: {
                            self.flagTapped(number)
                            self.flagTappedNow = self.countries[number]
                        }) {
                            Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .white, radius: 2)
                        }
                    }
                    HStack {
                        Text("Your score is: ")
                            .foregroundColor(.white)
                        Text("\(score)")
                            .foregroundColor(.white)
                            .font(.title)
                    }
                    Spacer()
                }
            }
        }.alert(isPresented: $showingScore) {
            var someText = ""
            if scoreTitle == "Wrong!" {
                someText = "That's the flag of \(flagTappedNow)"
            }
            return Alert(title: Text("\(scoreTitle) \(someText)"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
            self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong!"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
