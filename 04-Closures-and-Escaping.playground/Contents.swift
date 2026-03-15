//: Playground Practice — Closures and Escaping
//: Rapid Sheet: "What's the difference between escaping and non-escaping closures?"
//: Non-escaping runs before function returns; @escaping can outlive the function.

import Foundation

// MARK: - Non-escaping (default) — runs before function returns
func performSync(completion: () -> Void) {
    completion()
}

// MARK: - Escaping — can outlive the function (stored, async, etc.)
var storedClosure: (() -> Void)?

func performAsync(completion: @escaping () -> Void) {
    storedClosure = completion
    DispatchQueue.main.async {
        completion()
    }
}

// MARK: - Capture list — [weak self] to avoid retain cycles
class DataFetcher {
    var onComplete: (() -> Void)?

    func fetch(completion: @escaping () -> Void) {
        onComplete = completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard self != nil else { return }
            completion()
        }
    }
}

print("Non-escaping:")
performSync { print("  Ran synchronously") }

print("\nEscaping:")
performAsync { print("  Ran asynchronously") }
