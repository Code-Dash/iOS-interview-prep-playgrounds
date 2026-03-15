//: Playground Practice — Protocol Composition
//: Rapid Sheet: "What is protocol composition? How does it differ from inheritance?"
//: Run this, then practice explaining the & operator and when to use it.

import Foundation

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct User: Named, Aged {
    let name: String
    let age: Int
}

// MARK: - Compose protocols with &
func greet(_ value: Named & Aged) {
    print("\(value.name), \(value.age)")
}

let user = User(name: "Alice", age: 30)
greet(user)

// MARK: - Constrain generic with composition
func oldest<T: Named & Aged>(_ items: [T]) -> T? {
    items.max(by: { $0.age < $1.age })
}

let users = [User(name: "Alice", age: 30), User(name: "Bob", age: 25)]
print("Oldest: \(String(describing: oldest(users)?.name))")
