//: Playground Practice — Enums and Associated Values
//: Rapid Sheet: "How do Swift enums with associated values work? Give an example."
//: Pattern matching with switch and if case.

import Foundation

enum NetworkState {
    case idle
    case loading(progress: Double)
    case loaded(Data)
    case failed(Error)
}

// Create a simple error for the example
struct MockError: Error {}

// MARK: - Pattern matching with switch
let state: NetworkState = .loading(progress: 0.5)

switch state {
case .idle:
    print("Idle")
case .loading(let progress):
    print("Loading: \(Int(progress * 100))%")
case .loaded(let data):
    print("Loaded \(data.count) bytes")
case .failed(let error):
    print("Failed: \(error)")
}

// MARK: - if case — extract when you only care about one case
if case .loading(let progress) = state {
    print("Progress: \(progress)")
}
