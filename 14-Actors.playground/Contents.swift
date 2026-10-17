//: Playground Practice — Actors
//: Rapid Sheet: "What are actors in Swift? When would you use them?"
//: An actor protects its mutable state: one task at a time runs on it; outside callers `await`.

import Foundation

actor Counter {
    private(set) var count = 0

    func increment() {
        count += 1          // no lock needed: the actor serializes access
    }
}

// MARK: - 1,000 concurrent increments, no data race
let counter = Counter()
await withTaskGroup { group in
    for _ in 0..<1_000 {
        group.addTask { await counter.increment() }
    }
}
print("Counter value:", await counter.count)   // 1000

// MARK: - Reentrancy: state can change across an await inside an actor
actor BankAccount {
    private(set) var balance = 100

    func withdraw(_ amount: Int) async -> Bool {
        guard balance >= amount else { return false }
        try? await Task.sleep(for: .milliseconds(10))   // suspension point: other calls may run here
        guard balance >= amount else { return false }   // re-check after the await
        balance -= amount
        return true
    }
}

let account = BankAccount()
async let w1 = account.withdraw(80)
async let w2 = account.withdraw(80)
print("Withdrawals:", await [w1, w2], "balance:", await account.balance)  // one succeeds, balance 20
