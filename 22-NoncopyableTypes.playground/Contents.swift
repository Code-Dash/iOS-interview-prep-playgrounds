//: Playground Practice — Noncopyable Types
//: Rapid Sheet: "What are noncopyable types in Swift? What do `consuming` and `borrowing` mean, and when would you use them?"
//: `~Copyable` types are moved, not copied: exactly one owner at a time.

import Foundation

struct FileToken: ~Copyable {
    let descriptor: Int32          // `discard self` needs trivially-destroyed stored properties
    init(descriptor: Int32) { self.descriptor = descriptor; print("open", descriptor) }

    borrowing func describe() -> String { "token for fd \(descriptor)" }   // read-only access

    consuming func close() {                                               // ends the value's lifetime
        print("close", descriptor)
        discard self                                                       // skip deinit: already cleaned up
    }

    deinit { print("deinit (forgot to close)", descriptor) }
}

func inspect(_ token: borrowing FileToken) {
    print("inspect:", token.describe())
}

// Top-level playground variables are globals, and globals can't be consumed,
// so the ownership demo lives in a function with local variables.
func ownershipDemo() {
    let token = FileToken(descriptor: 3)
    inspect(token)          // borrow: caller keeps ownership
    token.close()           // consume: `token` can't be used after this
    // token.describe()     // ❌ error: 'token' used after consume

    // MARK: - Moving ownership
    func takeOwnership(_ t: consuming FileToken) { print("now owned by callee:", t.descriptor) }
    let other = FileToken(descriptor: 4)
    takeOwnership(other)    // moved; deinit runs when the callee's copy ends
}

// MARK: - Typestate: states as separate noncopyable types
struct Draft: ~Copyable { var text: String; consuming func submit() -> Submitted { Submitted(text: text) } }
struct Submitted: ~Copyable { let text: String }
func typestateDemo() {
    let draft = Draft(text: "Hello")
    let sent = draft.submit()   // the draft no longer exists, so it can't be edited after submit
    print("submitted:", sent.text)
}

ownershipDemo()
typestateDemo()
