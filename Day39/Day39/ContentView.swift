//
//  ContentView.swift
//  Day39
//
//  Created by Sean Hong on 2023/04/09.
//

import SwiftUI

struct ContentView: View {
    let layout = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")


    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.launchDate ?? "N/A")
                                        .font(.caption)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
