//
//  ContentView.swift
//  Day19
//
//  Created by Sean Hong on 2023/01/24.
//

import SwiftUI


struct ContentView: View {
    enum TimeUnits: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case days = "Days"
        
        var convertRate: Double {
            switch self {
            case .seconds: return 1
            case .minutes: return 60
            case .hours: return 3600
            case .days: return 86400
            }
        }
    }
    
    @State private var unitFrom: TimeUnits = .seconds
    @State private var unitTo: TimeUnits = .seconds
    @State private var value: Double?
    
    var result: Double {
        guard let value = value else { return 0.0 }
        if unitFrom.convertRate > unitTo.convertRate {
            return value * unitFrom.convertRate / unitTo.convertRate
        } else if unitFrom.convertRate < unitTo.convertRate {
            return value / (unitTo.convertRate / unitFrom.convertRate)
        } else {
            return value
        }
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Example) 120", value: $value, format: .number)
                        .keyboardType(.numberPad)
                    Picker("", selection: $unitFrom) {
                        ForEach(TimeUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Unit to convert from")
                }
                
                Section {
                    Text("\(result)")
                    Picker("", selection: $unitTo) {
                        ForEach(TimeUnits.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Unit to convert to")
                }
            }
            .navigationTitle("Unit Converter")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
