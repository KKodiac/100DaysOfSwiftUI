import Cocoa

/* Make a class hierarchy for animals,
 starting with Animal at the top,
 then Dog and Cat as subclasses,
 then Corgi and Poodle as subclasses of Dog,
 and Persian and Lion as subclasses of Cat. */

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    override init(legs: Int) {
        super.init(legs: legs)
    }
    
    func speak() {
        print("Bark")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Corgi Barks")
    }
}

class Poodle: Dog {
    override func speak() {
         print("Poodle Barks")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Meow")
    }
}

class Persian: Cat {
    override func speak() {
        print("Persian Meow")
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar")
    }
}

let persian = Persian(legs: 4, isTame: true)
let lion = Lion(legs: 4, isTame: false)
let poodle = Poodle(legs: 4)
let corgi = Corgi(legs: 4)

