//: Playground Practice — Key Paths
//: Rapid Sheet: "What are key paths in Swift? How do you use them?"
//: Run this, then practice explaining KeyPath syntax and use cases.

import Foundation

struct Person {
    let name: String
    var age: Int
}

// MARK: - KeyPath for property access
let nameKeyPath = \Person.name
let ageKeyPath = \Person.age

let person = Person(name: "Alice", age: 30)
print("KeyPath name: \(person[keyPath: nameKeyPath])")
print("KeyPath age: \(person[keyPath: ageKeyPath])")

// MARK: - KeyPath with map
let people = [
    Person(name: "Alice", age: 30),
    Person(name: "Bob", age: 25),
]
let names = people.map(\.name)
print("map with KeyPath: \(names)")
