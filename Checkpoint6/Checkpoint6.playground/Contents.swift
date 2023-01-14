import Cocoa

/* Create a struct to store information about a car including:
 1. Model
 2. Number of seats
 3. Current gear
 4. Method(change gear up, down)
Access control,
 */

enum GearError: Error {
    case maxGear, minGear
}

extension GearError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .maxGear:
            return "Current Gear at Max"
        case .minGear:
            return "Current Gear at Min"
        }
    }
}

struct Car {
    private let model: String
    private let numberOfSeats: Int
    private var gear: Int = 1 {
        willSet {
            print("Gear set to \(newValue)")
        }
    }
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func gearUp() throws {
        if gear == 10 {
            throw GearError.maxGear
        } else {
            gear += 1
        }
    }
    
    mutating func gearDown() throws {
        if gear == 1 {
            throw GearError.minGear
        } else {
            gear -= 1
        }
    }
}

var car = Car(model: "Prius", numberOfSeats: 5)
do {
//    try car.gearDown()
    try car.gearUp()
    try car.gearDown()
} catch {
    print("[GearError] \(error.localizedDescription)")
}
