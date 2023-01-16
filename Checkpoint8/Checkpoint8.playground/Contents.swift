import Cocoa

/* Make a protocol that describes a building,
 adding various properties and methods, then create two structs,
 House and Office, that conform to it.
 
 1. A property storing how many rooms it has.
 2. A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
 3. A property storing the name of the estate agent responsible for selling the building.
 4. A method for printing the sales summary of the building, describing what it is along with its other properties.
 */

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var agent: String { get }
    
    func summary() -> ()
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    
    func summary() {
        print("House summary: \(rooms) rooms, $\(cost), contact \(agent) ")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    
    func summary() {
        print("Office summary: \(rooms) rooms, $\(cost), contact \(agent) ")
    }
}

let house = House(rooms: 3, cost: 500_000, agent: "James Ramerez")
let office = Office(rooms: 10, cost: 1_000_000, agent: "Sam Her")
house.summary()
office.summary()
