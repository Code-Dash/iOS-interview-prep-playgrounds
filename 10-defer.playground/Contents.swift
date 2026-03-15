//: Playground Practice — defer
//: Rapid Sheet: "What does the defer keyword do? When would you use it?"
//: Runs when scope exits (return, throw, break); LIFO order for multiple defers.

import Foundation

// MARK: - Multiple defers — LIFO (last defined, first executed)
func example() {
    defer { print("third") }
    defer { print("second") }
    defer { print("first") }
    print("body")
}
example()
// Output: body, first, second, third

// MARK: - defer with early return — still runs
func process(shouldContinue: Bool) {
    defer { print("Cleanup runs") }
    guard shouldContinue else { return }
    print("Processing...")
}
process(shouldContinue: false)
process(shouldContinue: true)
