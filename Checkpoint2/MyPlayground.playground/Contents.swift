import Cocoa

/* Checkpoint 2
 1. Create an array
 2. Print number of items in the array.
 3. Print number of unique items in the array.
 */

let singers: [String] = ["Redbone", "John K", "Chirstian French", "Bruno Mars", "Redbone"]
let uniqueSingers: Set<String> = Set(singers)

print(singers.count)
print(uniqueSingers.count)
