//
//  CustomText.swift
//  Day39
//
//  Created by Sean Hong on 2023/04/09.
//

import SwiftUI

struct CustomText: View {
    let text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText("Hello")
    }
}
