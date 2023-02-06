//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sean Hong on 2023/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var gameInterval = 8
    @State private var showAskReplay = false
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var flaggedTapped = false
    @State private var animationAmount = [0.0, 0.0, 0.0]
    @State private var animationOpacity = [1.0, 1.0, 1.0]
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the Flag")
                    .largeBlueTitle()
                VStack(spacing: 15) {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .clipShape(Capsule())
                        .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 1, y: 0, z: 0))
                        .opacity(animationOpacity[number])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Play again?", isPresented: $showAskReplay) {
            Button("Yes", action: askReplay)
        } message: {
            Text("Your final score \(score)!")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation {
                animationAmount[number] += 360
                switch number {
                case 0:
                    animationOpacity[1] = 0.25
                    animationOpacity[2] = 0.25
                case 1:
                    animationOpacity[0] = 0.25
                    animationOpacity[2] = 0.25
                case 2:
                    animationOpacity[0] = 0.25
                    animationOpacity[1] = 0.25
                default:
                    return
                }
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        gameInterval -= 1
        countries.shuffle()
        animationOpacity = [1.0, 1.0, 1.0]
        correctAnswer = Int.random(in: 0...2)
        if gameInterval == 0 {
            showAskReplay = true
        }
    }
    
    func askReplay() {
        gameInterval = 8
        score = 0
    }
}

struct FlagImage: View {
    let country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
    
}

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
