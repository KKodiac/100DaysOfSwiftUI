//
//  ContentView.swift
//  Day35
//
//  Created by Sean Hong on 2023/02/07.
//

import SwiftUI

struct ContentView: View {
    let buttonColor: [[Color]] = [[.red, .blue, .green],
                                  [.yellow, .indigo, .brown],
                                  [.teal, .orange, .cyan],
                                  [.mint, .pink, .purple]]
    
    let modeArray: [[Int]] = [[1,2,3],[4,5,6],[7,8,9],[10,11,12]]
    @State private var isPresented: Bool = false
    @State private var selectedMode: Int = 0
    @State private var numberOfQuestions: Int = 5
    @State private var difficultyRangeMax: Int = 2
    @State private var selectedButtonColor: Color = .white
    
    var body: some View {
        Grid {
            Text("구구단 퀴즈!").font(.title).bold()
            ForEach(1..<5) { row in
                GridRow {
                    ForEach(1..<4) { col in
                        Button(action: {
                            isPresented.toggle()
                            selectedMode = modeArray[row-1][col-1]
                            selectedButtonColor = buttonColor[row-1][col-1]
                        }, label: {
                            Text("\(modeArray[row-1][col-1])단")
                                .font(.title)
                                .bold()
                                .frame(maxWidth: 200, minHeight: 100)
                        })
                        .background(buttonColor[row-1][col-1])
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    }
                }
            }
            
            Text("게임 설정").font(.headline).padding(.top)
            HStack {
                Stepper(value: $numberOfQuestions, in: 5...20, step: 5) {
                    Text("문제수 \(numberOfQuestions)")
                        .animation(.easeIn(duration: 0.25))
                }
                Stepper(value: $difficultyRangeMax, in: 2...12) {
                    Text("난이도 \(difficultyRangeMax)")
                        .animation(.easeIn(duration: 0.25))
                    
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isPresented) {
            QuizView(mode: $selectedMode,
                     numberOfQuestions: $numberOfQuestions,
                     buttonColor: $selectedButtonColor,
                     difficultyRange: 1..<difficultyRangeMax+1)
        }
    }
}

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var mode: Int
    @Binding var numberOfQuestions: Int
    @Binding var buttonColor: Color
    var difficultyRange: Range<Int>
    
    @State var number: Int = 0
    @State var answer: Int = 0
    @State var score : Int = 0
    @State var choices: [Int] = [0,0,0]
    @State var isVisible: Bool = true
    @State var isAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(mode)단 난이도 \(difficultyRange.upperBound)")
                Text(numberOfQuestions == 0 ? "마지막 문제!" : "\(numberOfQuestions) 문제 남았어요!")
                    .font(.headline)
                    .animation(.interactiveSpring())
                Text("현재 점수: \(score)")
                ZStack {
                    Button("시작하기!") {
                        generateQuestion()
                        withAnimation {
                            isVisible.toggle()
                        }
                    }
                    .opacity(isVisible ? 1 : 0)
                    .disabled(!isVisible)
                    Text("\(mode) 곱하기 \(number)는?")
                        .opacity(!isVisible ? 1 : 0)
                        .disabled(isVisible)
                }
                HStack {
                    ForEach(0..<3) { index in
                        Button(action: {
                            evaluate(userChosen: choices[index])
                            generateQuestion()
                        }, label: {
                            Text("\(choices[index])")
                                .font(.title)
                                .bold()
                                .frame(maxWidth: 200, minHeight: 100)
                        })
                        .background(buttonColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .opacity(!isVisible ? 1 : 0)
                        .disabled(isVisible)
                    }
                }
                .padding()
            }
            .bold()
            .font(.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("모드 선택으로 돌아가기") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $isAlert) {
                Alert(
                    title: Text("게임 오버"),
                    message: Text("최종 스코어: \(score)"),
                    primaryButton: .default(
                        Text("홈으로"),
                        action: {dismiss()}
                    ), secondaryButton: .cancel(Text("취소"))
                )
            }
        }
    }
    
    private func generateQuestion() {
        if numberOfQuestions == 0 {
            isAlert.toggle()
            return
        }
        numberOfQuestions -= 1
        number = Array(difficultyRange).randomElement()!
        answer = number * mode
        choices = []
        choices.append(answer)
        choices.append(Array(1..<145).randomElement()!)
        choices.append(Array(1..<145).randomElement()!)
        choices.shuffle()
    }
    
    private func evaluate(userChosen: Int) {
        if userChosen == answer {
            score += 1
        } else {
            score -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
