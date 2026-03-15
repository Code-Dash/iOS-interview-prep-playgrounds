//: Playground Practice — UserDefaults
//: Rapid Sheet: "What is UserDefaults? When would you use it?"
//: Run this, then practice explaining key-value storage and when to use it.

import Foundation

// MARK: - Standard UserDefaults
let defaults = UserDefaults.standard

// Write
defaults.set("dark", forKey: "theme")
defaults.set(42, forKey: "launchCount")
defaults.set(true, forKey: "onboardingCompleted")

// Read
let theme = defaults.string(forKey: "theme")
let count = defaults.integer(forKey: "launchCount")
let completed = defaults.bool(forKey: "onboardingCompleted")

print("Theme: \(theme ?? "nil")")
print("Launch count: \(count)")
print("Onboarding completed: \(completed)")

// MARK: - Codable objects (encode to Data)
struct User: Codable {
    let name: String
    let id: Int
}

let user = User(name: "Alice", id: 1)
if let data = try? JSONEncoder().encode(user) {
    defaults.set(data, forKey: "currentUser")
}

if let data = defaults.data(forKey: "currentUser"),
   let decoded = try? JSONDecoder().decode(User.self, from: data) {
    print("\nDecoded user: \(decoded.name)")
}

// MARK: - Test suite (for unit tests — isolated from app)
let testSuite = UserDefaults(suiteName: "Test")!
testSuite.set("testValue", forKey: "testKey")
print("\nTest suite value: \(testSuite.string(forKey: "testKey") ?? "nil")")
// In tests: tearDown with testSuite.removePersistentDomain(forName: "Test")
