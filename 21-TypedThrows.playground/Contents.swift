//: Playground Practice — Typed Throws (Swift 6)
//: Rapid Sheet: "What are typed throws in Swift 6? When should you use them, and when shouldn't you?"
//: `throws(E)` declares the exact error type, so callers can switch exhaustively.

import Foundation

enum ParseError: Error {
    case empty
    case notANumber(String)
    case outOfRange(Int)
}

func parseAge(_ text: String) throws(ParseError) -> Int {
    guard !text.isEmpty else { throw .empty }
    guard let value = Int(text) else { throw .notANumber(text) }
    guard (0...150).contains(value) else { throw .outOfRange(value) }
    return value
}

// MARK: - The catch knows `error` is ParseError: exhaustive switch, no default
for input in ["42", "", "abc", "200"] {
    do {
        print("Parsed:", try parseAge(input))
    } catch {
        switch error {
        case .empty: print("Empty input")
        case .notANumber(let text): print("Not a number:", text)
        case .outOfRange(let value): print("Out of range:", value)
        }
    }
}

// MARK: - Generic pass-through: if the closure can't throw, neither can map
let doubled = [1, 2, 3].map { $0 * 2 }          // E == Never → no `try`
print(doubled)

// MARK: - Translate at layer boundaries instead of leaking low-level errors
enum ProfileError: Error { case invalidAge }

func loadAge(from text: String) throws(ProfileError) -> Int {
    do { return try parseAge(text) }
    catch { throw .invalidAge }
}
print((try? loadAge(from: "x")) == nil ? "Mapped to ProfileError.invalidAge" : "ok")

//: When NOT to use: most app code (errors from networking/decoding are open-ended).
//: Good fits: small closed error sets, parsing, libraries, embedded code.
