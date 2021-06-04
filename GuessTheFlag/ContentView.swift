//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mahmoud Fouad on 5/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany",                                 "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain",
                                    "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var resultTitle = "Wrong"
    @State private var showingAlert: Bool = false
    @State private var score = 0
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flageTapped(number)
                    }) {
                        Image(self.countries[number])
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Text("Score: \(score)")
                Spacer()
            }
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text(resultTitle),
                  message: Text("Your score is \(score)"),
                  dismissButton: .default(Text("Continue"),
                                          action: {  self.askQuestion()  }))
        }
    }
    
    private func flageTapped(_ number: Int) {
        correctAnswer == number ? validAnswer() : wrongAnswer()
        showingAlert = true
    }
    
    private func validAnswer() {
        resultTitle = "Correct"
        score += 10
    }
    
    private func wrongAnswer() {
        resultTitle = "Wrong"
        guard score >= 10 else { return }
        score -= 10
    }
    
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
