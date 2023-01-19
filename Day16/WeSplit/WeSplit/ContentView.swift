//
//  ContentView.swift
//  WeSplit
//
//  Created by Sean Hong on 2023/01/19.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    @State private var tapCount = 0
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Enter your name", text: $name)
                    Section {
                        Text("Hello, World!")
                        Text("Your name is \(name)")
                    }
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id:\.self) {
                            Text($0)
                        }
                    }
                }
                Button(action: { tapCount += 1 }, label: {
                    Text("Button Tapped \(tapCount)")
                })
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
