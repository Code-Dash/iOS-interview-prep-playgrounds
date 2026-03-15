//: Playground Practice — Keychain
//: Rapid Sheet: "What is the Keychain? When would you use it?"
//: Run this, then practice explaining encrypted storage for secrets.
//: Note: Keychain requires a real app context; this demonstrates the API pattern.

import Foundation
import Security

// MARK: - Keychain helper (conceptual — full implementation needs app)
// In a real app, use SecItemAdd, SecItemCopyMatching, SecItemUpdate, SecItemDelete

func keychainAdd(key: String, value: String) -> Bool {
    guard let data = value.data(using: .utf8) else { return false }
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecValueData as String: data,
        kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
    ]
    // Remove existing to avoid duplicate error
    SecItemDelete(query as CFDictionary)
    let status = SecItemAdd(query as CFDictionary, nil)
    return status == errSecSuccess
}

func keychainRead(key: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    guard status == errSecSuccess, let data = result as? Data else { return nil }
    return String(data: data, encoding: .utf8)
}

// MARK: - Usage (run in app target for real Keychain access)
let key = "authToken"
let token = "secret-jwt-token"

if keychainAdd(key: key, value: token) {
    print("Stored token in Keychain")
}

if let retrieved = keychainRead(key: key) {
    print("Retrieved: \(retrieved)")
}

// MARK: - Key points to explain
// - Keychain: encrypted storage for passwords, tokens, certificates
// - kSecClassGenericPassword for tokens
// - kSecAttrAccessibleWhenUnlocked: accessible when device unlocked
// - Never use UserDefaults for secrets
// - App groups for sharing with extensions
