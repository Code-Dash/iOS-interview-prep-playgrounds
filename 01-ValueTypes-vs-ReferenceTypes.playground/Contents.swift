//: Playground Practice — Value Types vs Reference Types
//: Rapid Sheet: "What's the difference between value types and reference types in Swift?"
//: Run this, then practice explaining the output aloud.

import Foundation

// MARK: - Value Type — each variable gets its own copy
struct Point {
    var x: Int
    var y: Int
}

var a = Point(x: 1, y: 2)
var b = a
b.x = 10  // Only b changes; a is unchanged

print("Value type:")
print("  a = (\(a.x), \(a.y))")  // (1, 2)
print("  b = (\(b.x), \(b.y))")  // (10, 2)

// MARK: - Reference Type — shared instance
class User {
    var name: String
    init(name: String) { self.name = name }
}

let user1 = User(name: "Alice")
let user2 = user1
user2.name = "Bob"  // user1.name is also "Bob" — same instance!

print("\nReference type:")
print("  user1.name = \(user1.name)")  // Bob
print("  user2.name = \(user2.name)")   // Bob
print("  Same instance? \(user1 === user2)")  // true
