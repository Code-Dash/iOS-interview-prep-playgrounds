//: Playground Practice — Result Type
//: Rapid Sheet: "What is the Result type? When would you use it instead of throws?"
//: success(T) or failure(Error); map, flatMap, get().

import Foundation

enum NetworkError: Error {
    case invalidURL
    case notFound
}

struct User {
    let id: Int
    let name: String
}

// MARK: - Returning Result
func fetchUser(id: Int) -> Result<User, NetworkError> {
    guard id > 0 else { return .failure(.invalidURL) }
    return .success(User(id: id, name: "Alice"))
}

// MARK: - switch on Result
switch fetchUser(id: 1) {
case .success(let user):
    print("Success: \(user.name)")
case .failure(let error):
    print("Failure: \(error)")
}

// MARK: - map — transform success value
let nameResult = fetchUser(id: 1).map { $0.name }
print("Mapped: \(nameResult)")

// MARK: - get() — convert to throws
do {
    let user = try fetchUser(id: 1).get()
    print("get(): \(user.name)")
} catch {
    print("get() threw: \(error)")
}
