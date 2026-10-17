//: Playground Practice — async/await
//: Rapid Sheet: "Explain async/await in Swift. How does it work?"
//: An async function can suspend at `await`; the caller waits without blocking a thread.
//: Playgrounds support top-level `await`, so no Task + sleep is needed.

import Foundation

struct User: Sendable {
    let id: Int
    let name: String
}

enum APIError: Error { case notFound }

// MARK: - async functions
func fetchUser(id: Int) async throws -> User {
    try await Task.sleep(for: .milliseconds(100))   // suspends; the thread is free meanwhile
    guard id > 0 else { throw APIError.notFound }
    return User(id: id, name: id == 1 ? "Alice" : "Bob")
}

// MARK: - Sequential: each await finishes before the next starts (~200 ms)
let first = try await fetchUser(id: 1)
let second = try await fetchUser(id: 2)
print("Sequential:", first.name, second.name)

// MARK: - Concurrent with async let (~100 ms)
async let a = fetchUser(id: 1)
async let b = fetchUser(id: 2)
let both = try await [a, b]
print("async let:", both.map(\.name))

// MARK: - Errors propagate with try
do {
    _ = try await fetchUser(id: 0)
} catch {
    print("Caught:", error)
}

// MARK: - From synchronous code (e.g. a button action) you start a Task
let task = Task { try await fetchUser(id: 1) }
print("From a Task:", try await task.value.name)
