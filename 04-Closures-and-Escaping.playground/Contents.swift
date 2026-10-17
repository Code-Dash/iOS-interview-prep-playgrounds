//: Playground Practice — Closures and Escaping
//: Rapid Sheet: "What's the difference between escaping and non-escaping closures?"
//: Non-escaping runs before the function returns; @escaping can be stored and called later.

import Foundation

// MARK: - Non-escaping (default): must run before the function returns
func performSync(_ work: () -> Void) {
    work()
}

// MARK: - Escaping: stored and called later
final class Notifier {
    private var handlers: [() -> Void] = []

    func register(_ handler: @escaping () -> Void) {   // stored → must be @escaping
        handlers.append(handler)
    }

    func fire() {
        handlers.forEach { $0() }
    }
}

// MARK: - Capture list: [weak self] stops a stored closure keeping its owner alive
final class Screen {
    let name: String
    init(name: String) { self.name = name }

    func subscribe(to notifier: Notifier) {
        notifier.register { [weak self] in
            guard let self else { print("  Screen is gone; nothing to do"); return }
            print("  \(name) refreshed")
        }
    }
    deinit { print("  \(name) deinit") }
}

// MARK: - Escaping across isolation: Swift 6 also wants it @Sendable
func performLater(_ work: @escaping @Sendable () -> Void) async {
    await Task { work() }.value
}

print("Non-escaping:")
performSync { print("  Ran before performSync returned") }

print("\nEscaping + [weak self]:")
let notifier = Notifier()
var screen: Screen? = Screen(name: "Profile")
screen?.subscribe(to: notifier)
notifier.fire()          // Profile refreshed
screen = nil             // Profile deinit (no retain cycle)
notifier.fire()          // Screen is gone

print("\n@Sendable escaping closure:")
await performLater { print("  Ran in a Task") }
