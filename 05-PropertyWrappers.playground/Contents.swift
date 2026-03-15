//: Playground Practice — Property Wrappers
//: Rapid Sheet: "What are property wrappers? Give examples of when you'd use them."
//: Requires wrappedValue; optionally projectedValue (e.g., $ for Binding).

import Foundation

// MARK: - Simple wrapper — transforms on set
@propertyWrapper
struct Capitalized {
    private var value: String = ""
    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var name: String
}

var user = User(name: "alice")
print("Capitalized: \(user.name)")  // Alice
user.name = "bob"
print("After set: \(user.name)")    // Bob

// MARK: - Wrapper with parameters — Clamped
@propertyWrapper
struct Clamped<Value: Comparable> {
    private var value: Value
    let range: ClosedRange<Value>

    var wrappedValue: Value {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }

    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

struct Score {
    @Clamped(0...100) var value: Int = 0
}

var score = Score(value: 50)
print("\nClamped 50: \(score.value)")
score.value = 150
print("Clamped 150 → \(score.value)")  // 100
