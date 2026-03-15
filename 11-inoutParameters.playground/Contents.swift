//: Playground Practice — inout Parameters
//: Rapid Sheet: "What does inout do? How does it differ from passing by reference?"
//: Copy-in, copy-out; use & at call site.

import Foundation

// MARK: - swap — classic inout
func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 1, y = 2
swap(&x, &y)
print("After swap: x=\(x), y=\(y)")  // x=2, y=1

// MARK: - increment — modify in place
func increment(_ value: inout Int) {
    value += 1
}

var count = 0
increment(&count)
print("After increment: \(count)")  // 1
