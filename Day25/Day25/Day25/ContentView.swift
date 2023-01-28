//
//  ContentView.swift
//  Day25
//
//  Created by Sean Hong on 2023/01/28.
//

import SwiftUI

struct ContentView: View {
    @State private var moves: [String] = ["Rock", "Paper", "Scissors"]
    @State private var promptChoices: [String] = ["Win", "Lose"]
    @State private var prompt: Int = Int.random(in: 0...1)
    @State private var opponentSelection: Int = Int.random(in: 0...2)
    @State private var turns = 10
    @State private var scores = 0
    @State private var selectedMove: String = ""
    @State private var isGameOver: Bool = false
    var body: some View {
        ZStack {
            Color.accentColor.ignoresSafeArea()
            VStack {
                Text("Play the game!")
                    .font(.largeTitle)
                VStack {
                    Text("You must \(promptChoices[prompt])")
                        .foregroundColor(.orange)
                        .font(.title)
                        .padding(.top)
                    HStack {
                        Text("\(moves[opponentSelection])")
                            .bold()
                            .foregroundColor(.black)
                            .frame(maxWidth: 100, maxHeight: 100)
                            .background(Color.yellow)
                            .cornerRadius(20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Text("Opponent")
                        .foregroundColor(.black)
                        .font(.title)
                    ZStack {
                        Divider()
                        Text("Score \(scores)")
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                    }
                    Text("You")
                        .foregroundColor(.black)
                        .font(.title)
                    HStack {
                        ForEach(moves, id: \.self) { move in
                            Button(action: {
                                selectedMove = move
                                playTurn()
                            }, label: {
                                Text("\(move)")
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: 100)
                            })
                            .background(Color.blue)
                            .shadow(radius: 50, x: 10, y: 10)
                            .cornerRadius(20)
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(Color.white)
                .foregroundColor(.black)
            }
            .alert("Game Over", isPresented: $isGameOver, actions: {
                Button("OK") {
                    turns = 10
                    scores = 0
                    isGameOver.toggle()
                }
            }, message: {
                Text("Play again?")
                Text("Your score is \(scores)")
            })
            .foregroundColor(.white)
        }
    }
    
    func playTurn() {
        if turns == 0 {
            isGameOver.toggle()
            return
        }
        turns -= 1
        evaluate()
        prompt = Int.random(in: 0...1)
        opponentSelection = Int.random(in: 0...2)
    }
    
    private func evaluate() {
        switch selectedMove {
        case "Rock":
            if promptChoices[prompt] == "Win" &&
                moves[opponentSelection] == "Scissors" {
                scores += 1
            } else if promptChoices[prompt] == "Lose" &&
                        moves[opponentSelection] == "Paper" {
                scores += 1
            }
            else {
                scores -= 1
            }
        case "Paper":
            if promptChoices[prompt] == "Win" &&
                moves[opponentSelection] == "Rock" {
                scores += 1
            } else if promptChoices[prompt] == "Lose" &&
                        moves[opponentSelection] == "Scissors" {
                scores += 1
            }
            else {
                scores -= 1
            }
        case "Scissors":
            if promptChoices[prompt] == "Win" &&
                moves[opponentSelection] == "Paper" {
                scores += 1
            } else if promptChoices[prompt] == "Lose" &&
                        moves[opponentSelection] == "Rock" {
                scores += 1
            }
            else {
                scores -= 1
            }
        default:
            return
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
