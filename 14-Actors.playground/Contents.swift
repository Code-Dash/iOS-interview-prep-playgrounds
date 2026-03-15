//: Playground Practice — Actors
//: Rapid Sheet: "What are actors in Swift? When would you use them?"
//: Isolated state; access from outside requires await.

import Foundation

actor Counter {
    var count = 0

    func increment() {
        count += 1
    }

    func get() -> Int {
        count
    }
}

// MARK: - Access from outside — async, await
Task {
    let counter = Counter()
    await counter.increment()
    await counter.increment()
    let value = await counter.get()
    print("Counter value: \(value)")  // 2
}

Thread.sleep(forTimeInterval: 0.1)
