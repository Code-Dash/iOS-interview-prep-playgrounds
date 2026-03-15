//: Playground Practice — Optionals and Optional Binding
//: Rapid Sheet: "What are optionals in Swift? How do you safely unwrap them?"
//: Run this, then practice explaining each unwrapping technique.

import Foundation

var name: String? = "Alice"

// MARK: - Optional binding (if let)
if let unwrapped = name {
    print("if let: \(unwrapped)")
}

// MARK: - guard let — early exit, value in scope for rest of function
func processName(_ name: String?) {
    guard let unwrapped = name else { return }
    print("guard let: \(unwrapped)")  // unwrapped available here
}

processName(name)

// MARK: - Nil coalescing
let displayName = name ?? "Unknown"
print("Nil coalescing: \(displayName)")

// MARK: - Optional chaining
let count = name?.count  // Int?
print("Optional chaining: count = \(String(describing: count))")

// MARK: - Try with nil
name = nil
let fallback = name ?? "Unknown"
print("\nWith nil: \(fallback)")
