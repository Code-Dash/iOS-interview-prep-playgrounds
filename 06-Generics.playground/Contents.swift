//: Playground Practice — Generics
//: Rapid Sheet: "How do generics work in Swift? When would you use them?"
//: Type parameters, constraints, and where clauses.

import Foundation

// MARK: - Generic function
func first<T>(_ array: [T]) -> T? {
    array.first
}

// MARK: - Generic with constraint
func find<T: Equatable>(_ value: T, in array: [T]) -> Int? {
    array.firstIndex(of: value)
}

// MARK: - Generic type
struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        items.popLast()
    }
}

// MARK: - Where clause
func process<T>(_ value: T) where T: Collection, T.Element: Equatable {
    print("Processed collection with \(value.count) elements")
}

let nums = [1, 2, 3]
print("first: \(String(describing: first(nums)))")
print("find 2: \(String(describing: find(2, in: nums)))")

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
print("pop: \(String(describing: stack.pop()))")

process([1, 2, 3])
