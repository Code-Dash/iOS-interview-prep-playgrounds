//: Playground Practice — guard vs if let
//: Rapid Sheet: "When would you use `guard let` instead of `if let`?"
//: Compare: guard keeps unwrapped value in scope; if let keeps it only in the block.

import Foundation

struct User {
    let name: String
}

// MARK: - guard let — unwrapped value available for rest of function
func process(user: User?) {
    guard let user = user else { return }
    print("guard: \(user.name)")  // user in scope for entire function
}

// MARK: - if let — unwrapped value only inside block
func processIf(user: User?) {
    if let user = user {
        print("if let: \(user.name)")
    }
    // user not in scope here
}

// MARK: - Multiple guards — validate prerequisites, fail fast
func load(id: Int?) {
    guard let id = id else {
        print("load: id is nil")
        return
    }
    guard id > 0 else {
        print("load: id must be positive")
        return
    }
    print("load: proceeding with id \(id)")
}

process(user: User(name: "Alice"))
processIf(user: User(name: "Bob"))
load(id: 42)
load(id: nil)
load(id: -1)
