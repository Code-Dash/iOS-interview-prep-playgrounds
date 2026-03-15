//: Playground Practice — map, flatMap, compactMap
//: Rapid Sheet: "Explain map, flatMap, and compactMap. When would you use each?"
//: map: 1:1 transform; compactMap: transform + filter nil; flatMap: flatten or chain optionals.

import Foundation

let numbers = [1, 2, 3]

// MARK: - map — transform each element
let doubled = numbers.map { $0 * 2 }
print("map: \(doubled)")  // [2, 4, 6]

// MARK: - compactMap — transform and remove nils
let strings = ["1", "two", "3"]
let ints = strings.compactMap { Int($0) }
print("compactMap: \(ints)")  // [1, 3]

// MARK: - flatMap on Sequence — flatten nested collections
let nested = [[1, 2], [3, 4]]
let flat = nested.flatMap { $0 }
print("flatMap: \(flat)")  // [1, 2, 3, 4]

// MARK: - Optional.flatMap — chain optional transforms
let optional: Int? = Optional(2).flatMap { $0 > 0 ? $0 : nil }
print("Optional.flatMap: \(String(describing: optional))")  // Optional(2)
