//: Playground Practice — The @Observable Macro
//: Rapid Sheet: "What is the @Observable macro? How does it replace ObservableObject?"
//: Observation tracks the properties you actually read; changes to other properties don't notify you.

import Foundation
import Observation

@MainActor
@Observable
final class CartModel {
    var items: [String] = []
    var promoCode = ""
    @ObservationIgnored var analyticsID = UUID()   // not tracked

    var count: Int { items.count }                 // computed: tracked through `items`
}

let cart = CartModel()

// MARK: - withObservationTracking: one-shot, fires on willSet of a property read inside `apply`
@MainActor
func observeCount() {
    withObservationTracking {
        print("Reading count:", cart.count)        // registers interest in `items` only
    } onChange: {
        print("  → items will change")
        Task { @MainActor in observeCount() }      // re-register for the next change (one-shot API)
    }
}

observeCount()
cart.promoCode = "SAVE10"     // no output: `promoCode` wasn't read
cart.items.append("Book")     // → items will change
try? await Task.sleep(for: .milliseconds(50))
cart.items.append("Pen")      // → items will change
try? await Task.sleep(for: .milliseconds(50))

//: In SwiftUI: `@State private var cart = CartModel()` to own it, a plain `let` to read it,
//: `@Bindable` for $bindings, `.environment(cart)` + `@Environment(CartModel.self)` to share it.
//: iOS 26+: `for await count in Observations({ cart.count }) { … }` replaces `$property.sink`.
