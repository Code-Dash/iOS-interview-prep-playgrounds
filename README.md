# iOS Interview Prep — Playgrounds

26 Xcode playgrounds for **The iOS Interview Handbook (iOS 27 edition)**. Each playground opens with the exact interview question from the Rapid Drill Sheet: run it, change it, then practise explaining what it does.

**Requirements:** Xcode 27 (Swift 6.4). Playgrounds use the Swift 6 language mode and top-level `await`. Open any `.playground` folder in Xcode and run it.

| # | Playground | Topic |
|---|---|---|
| 01 | ValueTypes-vs-ReferenceTypes | Copy vs shared instance |
| 02 | Optionals-and-OptionalBinding | `if let`, `guard let`, `??`, chaining |
| 03 | Guard-vs-IfLet | Early exit vs branching |
| 04 | Closures-and-Escaping | Escaping, `[weak self]`, `@Sendable` |
| 05 | PropertyWrappers | `wrappedValue`, clamping |
| 06 | Generics | Constraints, generic types |
| 07 | Enums-and-AssociatedValues | Associated values, pattern matching |
| 08 | Codable | Encoding, decoding, `CodingKeys` |
| 09 | ResultType | `Result`, `map`, `get()` |
| 10 | defer | Cleanup order |
| 11 | inoutParameters | Copy-in/copy-out |
| 12 | map-flatMap-compactMap | Collection transforms |
| 13 | async-await | Sequential vs `async let`, errors, `Task` |
| 14 | Actors | Data-race-free state, reentrancy |
| 15 | Subscripts | Custom and safe subscripts |
| 16 | KeyPaths | Key paths as functions |
| 17 | ProtocolComposition | `A & B` |
| 18 | Ranges | Closed, half-open, one-sided |
| 19 | UserDefaults | Preferences (writes to the playground's defaults) |
| 20 | Keychain | Secure storage (writes to the keychain) |
| 21 | TypedThrows | `throws(E)` and exhaustive catch (Swift 6) |
| 22 | NoncopyableTypes | `~Copyable`, `borrowing`/`consuming`, typestate |
| 23 | Mutex-and-Atomic | `Synchronization` (iOS 18+) vs actors |
| 24 | Observable-Macro | `@Observable`, per-property tracking |
| 25 | InlineArray-and-Span | Swift 6.2 (iOS 26+ runtime) |
| 26 | Concurrent-and-Isolation | `@concurrent`, main-actor isolation (Swift 6.2) |

## Downloads

The `downloads/` folder contains the **Rapid Drill Sheet** (Markdown and PDF): all 537 questions from the book with a short answer, key points and related topics, generated from the book's source. The full book is available on Amazon.
