//
//  ContentView.swift
//  Day29
//
//  Created by Sean Hong on 2023/02/02.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
                ForEach(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
                Text("Your score is: \(score)")
            }
            .navigationTitle(rootWord)
            .textInputAutocapitalization(.never)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        startGame()
                    }, label: {
                        Text("Restart Game")
                    })
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isStartWord(word: answer) else {
            wordError(title: "Word not recognized", message: "Word is a start word!")
            return
        }
        
        guard shorterThanThree(word: answer) else {
            wordError(title: "Word not recognized", message: "Word is too short!")
            return
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
        
                rootWord = allWords.randomElement() ?? "silkworm"
        
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    private func shorterThanThree(word: String) -> Bool {
        return word.count < 3 ? true : false
    }
    
    private func isStartWord(word: String) -> Bool {
        return newWord == word ? true : false
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func scoreCount(word: String) {
        self.score += (word.count * usedWords.count)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
