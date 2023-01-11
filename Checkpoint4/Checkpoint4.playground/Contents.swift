import Cocoa

/*
 Write a function that accepts an integer from 1 through 10,000,
 and returns the integer square root of that number.
 1. You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
 2. If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
 3. You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
 4. If you can’t find the square root, throw a “no root” error.
 */

enum SQRTError: Error {
    case outOfBounds(number: Int)
    case noRoot(number: Int)
}

extension SQRTError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noRoot(let number):
            return "There exists no root for \(number)"
        case .outOfBounds(let number):
            return "\(number) is out of bounds. (needs to be 1 ~ 10000)"
        }
    }
}

extension Int {
    func customSquareRoot() throws -> Int {
        if 1 < self && self < 10_000 {
            for i in 1...self {
                if i * i == self {
                    return i
                }
            }
            throw SQRTError.noRoot(number: self)
        } else {
            throw SQRTError.outOfBounds(number: self)
        }
    }
}

do {
    let sqrtOfHundred = try 100.customSquareRoot()
    let sqrtOfFour = try 4.customSquareRoot()
    let sqrtOfThree = try 6.customSquareRoot()
} catch {
    print("[Error] \(error.localizedDescription)")
}

