//: Playground Practice — async/await
//: Rapid Sheet: "Explain async/await in Swift. How does it work?"
//: async function suspends; caller awaits; Task for calling from sync context.

import Foundation

struct User {
    let id: Int
    let name: String
}

// MARK: - async function
func fetchUser() async throws -> User {
    try await Task.sleep(nanoseconds: 100_000_000)  // 0.1s
    return User(id: 1, name: "Alice")
}

// MARK: - Call from sync context with Task
Task {
    do {
        let user = try await fetchUser()
        print("Fetched: \(user.name)")
    } catch {
        print("Error: \(error)")
    }
}

// Give async task time to complete
Thread.sleep(forTimeInterval: 0.2)
