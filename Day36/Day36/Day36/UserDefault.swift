//
//  UserDefaults.swift
//  Day36
//
//  Created by Sean Hong on 2023/02/08.
//

import SwiftUI

struct UserDefault: View {
    @AppStorage("tapCount") private var tapCount = 0
    // @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")

        }
    }
}


struct UserDefaults_Previews: PreviewProvider {
    static var previews: some View {
        UserDefault()
    }
}
