//
//  Day53App.swift
//  Day53
//
//  Created by Sean Hong on 2023/04/10.
//

import SwiftUI

@main
struct Day53App: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
