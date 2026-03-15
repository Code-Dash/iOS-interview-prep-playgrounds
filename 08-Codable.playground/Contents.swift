//: Playground Practice — Codable
//: Rapid Sheet: "What is Codable? How do you use it for JSON encoding and decoding?"
//: CodingKeys for key mapping; date strategies.

import Foundation

struct User: Codable {
    let id: Int
    var name: String
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
    }
}

// MARK: - Encode
let user = User(id: 1, name: "Alice", createdAt: Date())
let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
let data = try encoder.encode(user)
let jsonString = String(data: data, encoding: .utf8)!
print("Encoded: \(jsonString)")

// MARK: - Decode
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let jsonData = """
{"id": 2, "name": "Bob", "created_at": "2024-01-15T12:00:00Z"}
""".data(using: .utf8)!
let decoded = try decoder.decode(User.self, from: jsonData)
print("Decoded: \(decoded.name) (id: \(decoded.id))")
