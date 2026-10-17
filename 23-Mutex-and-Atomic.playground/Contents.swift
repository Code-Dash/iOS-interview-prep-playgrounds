//: Playground Practice — Mutex and Atomic (Synchronization, iOS 18+)
//: Rapid Sheet: "When would you use a lock (Mutex, NSLock) instead of an actor?"
//: `Mutex` gives short, synchronous critical sections; actors give async, serialized access.

import Foundation
import Synchronization

// MARK: - A Sendable cache protected by a Mutex (no @unchecked needed)
final class ImageCache: Sendable {
    private let storage = Mutex<[String: Int]>([:])     // value -> byte size, for the demo

    func insert(_ key: String, size: Int) {
        storage.withLock { $0[key] = size }
    }

    func size(for key: String) -> Int? {
        storage.withLock { $0[key] }
    }

    var count: Int { storage.withLock { $0.count } }
}

// MARK: - Atomic counter for simple statistics
final class Stats: Sendable {
    let hits = Atomic<Int>(0)
}

let cache = ImageCache()
let stats = Stats()

await withTaskGroup { group in
    for i in 0..<1_000 {
        group.addTask {
            cache.insert("img\(i % 100)", size: i)      // synchronous, safe from any thread
            stats.hits.add(1, ordering: .relaxed)
        }
    }
}

print("Entries:", cache.count)                                     // 100
print("Hits:", stats.hits.load(ordering: .relaxed))                // 1000

//: Rules of thumb:
//: - Never `await` inside `withLock` (it doesn't allow it, and you'd hold the lock across a suspension).
//: - Use an actor when callers can await and the work is longer or async.
//: - Older options: NSLock, OSAllocatedUnfairLock (iOS 16), serial DispatchQueue.
