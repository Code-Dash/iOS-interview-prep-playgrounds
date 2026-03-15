//: Playground Practice — Ranges
//: Rapid Sheet: "How do ranges work in Swift? Explain closed, half-open, and one-sided."
//: Run this, then practice explaining each range type.

import Foundation

let numbers = [10, 20, 30, 40, 50]

// MARK: - Closed range (includes both ends)
let closed = 1...5
print("Closed 1...5: \(Array(closed))")

// MARK: - Half-open range (excludes upper bound)
let halfOpen = 1..<5
print("Half-open 1..<5: \(Array(halfOpen))")

// MARK: - One-sided range (from index to end)
let suffix = numbers[2...]
print("Suffix from index 2: \(suffix)")

// MARK: - One-sided range (from start to index)
let prefix = numbers[..<3]
print("Prefix up to index 3: \(prefix)")

// MARK: - Range in switch
let value = 3
switch value {
case 1...5: print("In range 1...5")
default: break
}
