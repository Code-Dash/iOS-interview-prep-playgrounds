# The iOS Interview Handbook — Rapid Drill Sheet

Use this sheet to test your knowledge in interview scenarios. Cover the answers and try to articulate each response before revealing.

---

## Swift Fundamentals

### Value Types vs Reference Types

**Q:** What's the difference between value types and reference types in Swift? When would you use each?

<details>
<summary>Reveal answer</summary>

**Short answer:** In Swift, value types create a copy when assigned or passed, while reference types share a single instance. Structs, enums, and tuples are value types; classes, actors, and closures are reference types.

**Key points:**
- Value types: structs, enums, tuples — copied on assignment; each variable has its own copy
- Reference types: classes, actors, closures — share the same instance; multiple variables can point to the same object
- Swift favors value types for predictability and thread safety
- Classes/actors are used when you need identity, inheritance, or shared mutable state

**Related to check:** Copy-on-write (COW) for collections, `let` vs `var` and mutability, Protocol-oriented design

</details>

---

### Optionals and Optional Binding

**Q:** What are optionals in Swift? How do you safely unwrap them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Optionals represent a value that may or may not exist. They're Swift's way of handling absence of value explicitly, replacing null pointer exceptions.

**Key points:**
- `Optional<T>` or `T?` wraps a value or `nil`
- Unwrapping: optional binding (`if let`, `guard let`), nil coalescing (`??`), force unwrap (`!`)
- Optional chaining (`?.`) safely accesses properties/methods on optionals
- Never force unwrap in production unless you're certain the value exists

**Related to check:** Implicitly unwrapped optionals, Result type, Optional map/flatMap

</details>

---

### guard vs if let

**Q:** When would you use `guard let` instead of `if let`?

<details>
<summary>Reveal answer</summary>

**Short answer:** `guard let` is for early exit when a condition fails; `if let` is for branching when a condition succeeds. Use guard when you want to avoid nested code and fail fast.

**Key points:**
- `guard` must exit the scope (return, throw, break, continue) in the else block
- `guard let` keeps the unwrapped value in scope for the rest of the function
- `if let` keeps the unwrapped value only inside the if block
- Guard reduces nesting and makes the "happy path" more readable

**Related to check:** Optional binding, early return pattern, defensive programming

</details>

---

### Closures and Escaping

**Q:** What's the difference between escaping and non-escaping closures? When do you need @escaping?

<details>
<summary>Reveal answer</summary>

**Short answer:** A non-escaping closure is executed before the function returns. An escaping closure can outlive the function—it's stored or called later, so the compiler requires @escaping.

**Key points:**
- Default is non-escaping; closure must complete before function returns
- @escaping when: stored in a property, passed to async code, used in DispatchQueue
- Escaping closures capture `self` strongly by default—use `[weak self]` to avoid retain cycles
- Swift 3+ made closures non-escaping by default for safety

**Related to check:** Retain cycles, capture lists, async/await, Combine

</details>

---

### Protocols and Protocol-Oriented Programming

**Q:** Explain protocol-oriented programming in Swift. How does it differ from object-oriented programming?

<details>
<summary>Reveal answer</summary>

**Short answer:** Protocol-oriented programming emphasizes protocols and composition over class inheritance. Swift's protocols can have default implementations, associated types, and work with value types.

**Key points:**
- Protocols define contracts; types conform to them
- Protocol extensions provide default implementations without inheritance
- POP favors composition ("can do") over inheritance ("is a")
- Protocols work with structs and enums, not just classes

**Related to check:** Associated types, opaque return types, protocol witnesses, value types

</details>

---

### Generics

**Q:** How do generics work in Swift? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Generics let you write flexible, reusable code that works with any type while preserving type safety. The compiler generates specialized code for each type you use.

**Key points:**
- Type parameters in angle brackets: `func swap<T>(_ a: inout T, _ b: inout T)`
- Constraints with `where` clauses: `T: Equatable`, `T: SomeProtocol`
- Used throughout Swift: Array, Optional, Result, Dictionary
- Avoids code duplication and maintains compile-time type checking

**Related to check:** Protocol associated types, opaque types, type erasure

</details>

---

### Error Handling

**Q:** How does error handling work in Swift? Explain throw, try, try?, and try!.

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift uses typed errors with the Error protocol. Functions declare `throws`, callers use `try`, and errors propagate up until caught with `do-catch`.

**Key points:**
- Conform types to `Error`; use enums for multiple error cases
- `try` — must be in do-catch or throwing function
- `try?` — converts to optional; nil on error
- `try!` — force unwraps; crashes on error (avoid in production)

**Related to check:** Result type, async throws, NSError bridging

</details>

---

### Property Wrappers

**Q:** What are property wrappers? Give examples of when you'd use them.

<details>
<summary>Reveal answer</summary>

**Short answer:** Property wrappers add a layer of separation between how a property is stored and how it's defined. They're implemented with @propertyWrapper and provide reusable logic like @Published, @State, or @UserDefault.

**Key points:**
- Requires `wrappedValue`; optionally `projectedValue`
- Used by SwiftUI (@State, @Binding, @ObservedObject), Combine (@Published)
- Reduces boilerplate for common patterns (validation, persistence, threading)
- Can wrap any stored property

**Related to check:** @State, @Published, SwiftUI, Combine

</details>

---

### weak vs unowned

**Q:** What's the difference between weak and unowned references? When do you use each?

<details>
<summary>Reveal answer</summary>

**Short answer:** Both break strong reference cycles. Weak is optional and becomes nil when the object is deallocated; unowned assumes the reference never becomes nil during its lifetime.

**Key points:**
- `weak` — optional, must be var; becomes nil when referenced object deallocates
- `unowned` — non-optional; assumes referenced object outlives the reference (crashes if wrong)
- Use weak when the reference can outlive the object (e.g., closures, delegates)
- Use unowned when you're certain of lifetime (e.g., child never outlives parent)

**Related to check:** Retain cycles, ARC, capture lists, closures

</details>

---

### Access Control

**Q:** Explain Swift's access control levels: open, public, internal, fileprivate, and private.

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift has five levels: open and public for external access, internal as default, fileprivate for file scope, and private for the enclosing declaration.

**Key points:**
- `open` — public + subclassable/overridable from outside module (classes only)
- `public` — visible outside module; not subclassable/overridable from outside
- `internal` — default; visible within same module
- `fileprivate` — visible within same file
- `private` — visible within enclosing declaration (and extensions in same file)

**Related to check:** Modules, frameworks, encapsulation

</details>

---

### Computed vs Stored vs Lazy Properties

**Q:** What's the difference between computed, stored, and lazy properties?

<details>
<summary>Reveal answer</summary>

**Short answer:** Stored properties hold values in memory. Computed properties calculate a value on access. Lazy stored properties delay initialization until first access.

**Key points:**
- Stored: has backing storage, can be var or let
- Computed: no storage; get (and optionally set) runs each access
- Lazy: stored property initialized on first access; must be var
- Lazy is useful for expensive setup that might never be needed

**Related to check:** Property observers (willSet, didSet), property wrappers

</details>

---

### Extensions

**Q:** What are extensions in Swift? What can and can't they do?

<details>
<summary>Reveal answer</summary>

**Short answer:** Extensions add functionality to existing types without modifying the original definition. They can add computed properties, methods, initializers, and protocol conformances.

**Key points:**
- Add to classes, structs, enums, protocols
- Can add: methods, computed properties, initializers, subscripts, nested types
- Cannot add: stored properties, property observers, designated initializers that override
- Useful for organizing code, protocol conformance, adding convenience APIs

**Related to check:** Protocols, default implementations, protocol-oriented programming

</details>

---

### Enums and Associated Values

**Q:** How do Swift enums with associated values work? Give an example.

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift enums can carry associated values with each case, making them like discriminated unions. Each case can hold different types of data.

**Key points:**
- Associated values attach data to enum cases
- Different cases can have different associated types
- Pattern matching with switch or if case extracts values
- Used for Result, Optional, state machines, API responses

**Related to check:** Pattern matching, Optional, Result, state machines

</details>

---

### Codable

**Q:** What is Codable? How do you use it for JSON encoding and decoding?

<details>
<summary>Reveal answer</summary>

**Short answer:** Codable is a protocol that combines Encodable and Decodable. It lets types be serialized to and from external formats like JSON with minimal code.

**Key points:**
- Conform to Codable; compiler synthesizes implementation for stored properties
- Use JSONEncoder/JSONDecoder for JSON
- Custom CodingKeys for key mapping; custom init(from:) for complex cases
- Works with optional, nested types, arrays, dictionaries

**Related to check:** JSONEncoder, JSONDecoder, CodingKeys, Encodable, Decodable

</details>

---

### Result Type

**Q:** What is the Result type? When would you use it instead of throws?

<details>
<summary>Reveal answer</summary>

**Short answer:** Result is an enum that represents either success with a value or failure with an error. It's an alternative to throws when you want to handle outcomes as values.

**Key points:**
- `Result<Success, Failure>` where Failure: Error
- success(T) or failure(Error)
- Enables functional patterns: map, flatMap, get()
- Useful for async code, callbacks, when you want to defer error handling

**Related to check:** Error handling, async/await, Optional, Combine

</details>

---

### defer

**Q:** What does the defer keyword do? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** defer postpones execution of a block until the current scope exits—whether by normal return, throw, or break. It's useful for cleanup that must run before leaving.

**Key points:**
- Executes in reverse order of definition (LIFO) when multiple defers exist
- Runs when scope exits for any reason
- Commonly used for: closing files, releasing resources, undoing setup
- Cannot transfer control (return, throw, break) out of the defer block

**Related to check:** Scope, resource management, RAII pattern

</details>

---

### inout Parameters

**Q:** What does inout do? How does it differ from passing by reference?

<details>
<summary>Reveal answer</summary>

**Short answer:** inout passes a value by copy-in, copy-out. The function gets a copy, can modify it, and the modified value is written back when the function returns. It's not the same as a reference.

**Key points:**
- Caller must pass a variable (not constant or literal)
- Use & at call site: `modify(&x)`
- Value is copied in, modified, copied out—not shared during execution
- Works with value types; for reference types it passes the reference

**Related to check:** Value types, mutating methods, copy-in copy-out

</details>

---

### Optional Chaining

**Q:** What is optional chaining? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Optional chaining lets you call properties, methods, and subscripts on an optional. If the optional is nil, the chain short-circuits and returns nil instead of crashing.

**Key points:**
- Use ?. instead of . when the left side might be nil
- Entire expression becomes optional
- Stops at first nil; doesn't evaluate rest of chain
- Works with properties, methods, subscripts

**Related to check:** Optionals, nil coalescing, optional binding

</details>

---

### Equatable and Hashable

**Q:** What are Equatable and Hashable? When do you need to conform to them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Equatable lets types be compared with ==. Hashable extends Equatable and adds hashValue for use in sets and dictionary keys. The compiler can synthesize both for many types.

**Key points:**
- Equatable: required for ==, contains, firstIndex(of:)
- Hashable: required for Set, Dictionary keys
- Hashable implies Equatable; equal objects must have same hash
- Synthesized automatically for structs/enums whose stored properties conform

**Related to check:** Set, Dictionary, Comparable, Identifiable

</details>

---

### Collections: Array, Set, Dictionary

**Q:** What are the main collection types in Swift? When would you use Array vs Set vs Dictionary?

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift has three primary collections: Array for ordered elements, Set for unique unordered elements, and Dictionary for key-value pairs. All are value types and generic.

**Key points:**
- Array: ordered, allows duplicates, O(1) indexed access
- Set: unordered, unique elements, O(1) membership, requires Hashable
- Dictionary: key-value, unique keys, O(1) lookup, keys must be Hashable
- All use copy-on-write for performance

**Related to check:** Value types, Hashable, copy-on-write, Collection protocol

</details>

---

### Associated Types in Protocols

**Q:** What are associated types in protocols? How do they differ from generic type parameters?

<details>
<summary>Reveal answer</summary>

**Short answer:** Associated types are placeholders in protocols that conforming types specify. They let protocols define requirements without fixing the concrete type, similar to generics but for protocols.

**Key points:**
- Declared with `associatedtype Name`
- Each conforming type provides the concrete type
- Enables protocol requirements that work with "some type" the conformer chooses
- Used in Collection (Element), Sequence (Element), etc.

**Related to check:** Generics, type erasure, opaque types, protocol design

</details>

---

### static vs class

**Q:** What's the difference between static and class for methods and properties?

<details>
<summary>Reveal answer</summary>

**Short answer:** static defines type-level members that can't be overridden. class allows subclasses to override the member. Both are called on the type, not instances.

**Key points:**
- static: works for structs, enums, classes; not overridable
- class: classes only; overridable by subclasses
- Use static in protocols for requirements
- class var is rare; class func common for factory methods

**Related to check:** Type methods, inheritance, protocols

</details>

---

### Implicitly Unwrapped Optionals

**Q:** What are implicitly unwrapped optionals (IUOs)? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** An IUO is declared with ! and is an optional that's automatically unwrapped when accessed. It can still be nil—accessing when nil crashes. Used for two-phase initialization.

**Key points:**
- Syntax: `var name: String!`
- Behaves like optional until accessed, then unwraps automatically
- Primary use: UIKit/AppKit outlets (IBOutlet) that are nil until view loads
- Can still use optional binding and optional chaining on them

**Related to check:** Optionals, IBOutlet, two-phase initialization

</details>

---

### Type Erasure

**Q:** What is type erasure? When and why would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Type erasure hides the concrete type behind a protocol or wrapper. It's used when you need to store or return different concrete types that conform to a protocol with associated types.

**Key points:**
- Protocols with associated types (PATs) can't be used as existential types easily
- Type erasure creates a concrete wrapper (AnySequence, AnyPublisher) that hides the underlying type
- Enables heterogeneous collections: [AnyHashable], AnyPublisher
- Wrapper forwards to the underlying implementation

**Related to check:** Associated types, opaque types, existential types

</details>

---

### String vs NSString

**Q:** What's the difference between String and NSString? When would you use each?

<details>
<summary>Reveal answer</summary>

**Short answer:** String is Swift's native value type for text; NSString is Objective-C's reference type. String is preferred; use NSString when bridging to Objective-C APIs.

**Key points:**
- String: value type, Unicode-correct, uses Character and Substring
- NSString: reference type, from Foundation, used by many Cocoa APIs
- Swift automatically bridges between them when calling Obj-C
- String has better Swift integration (Collection, Codable, etc.)

**Related to check:** Value vs reference types, bridging, Unicode

</details>

---

### Opaque Types (some)

**Q:** What are opaque return types (some)? How do they differ from returning a protocol?

<details>
<summary>Reveal answer</summary>

**Short answer:** Opaque types use `some Protocol` to return a specific concrete type that conforms to a protocol, without exposing which type. The caller gets type identity without knowing the implementation.

**Key points:**
- `func make() -> some View` returns one concrete type (e.g., Text) every time
- Compiler knows the concrete type; enables optimizations
- Differs from `-> View` (existential) which loses concrete type
- Used heavily in SwiftUI for view composition

**Related to check:** Existential types, generics, SwiftUI View

</details>

---

### map, flatMap, compactMap

**Q:** Explain map, flatMap, and compactMap. When would you use each?

<details>
<summary>Reveal answer</summary>

**Short answer:** These transform elements in a sequence. map applies a transform; flatMap flattens nested optionals/arrays; compactMap transforms and removes nils.

**Key points:**
- map: [T] → (T → U) → [U]; 1:1 transform
- flatMap on Sequence: flattens nested collections (e.g., [[1,2],[3,4]] → [1,2,3,4])
- flatMap on Optional: chains optional transforms (Optional.flatMap still exists)
- compactMap on Sequence: transform + filter nil (replaced Sequence.flatMap for Optional-returning transforms in Swift 4.1)

**Related to check:** Higher-order functions, Optional, Sequence

</details>

---

### Nil Coalescing

**Q:** What is the nil coalescing operator? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** The nil coalescing operator ?? provides a default value when an optional is nil. It's shorthand for a ternary or if-let when you just need a fallback.

**Key points:**
- Syntax: `optional ?? default`
- Returns the unwrapped value if non-nil, otherwise the default
- Default is only evaluated if optional is nil (short-circuit)
- Works with optional chaining: `a?.b?.c ?? default`

**Related to check:** Optionals, optional chaining, optional binding

</details>

---

### Mutating Functions

**Q:** What does mutating mean for struct methods? Why don't classes need it?

<details>
<summary>Reveal answer</summary>

**Short answer:** mutating allows a struct or enum method to modify self. Since value types are copied, the method must be marked mutating so the compiler knows it will replace the instance. Classes are reference types, so their methods can mutate properties without this keyword.

**Key points:**
- Required for struct/enum methods that change properties
- Under the hood, self becomes an inout parameter
- Value types are immutable by default; mutating opts into mutation
- Classes don't need it—they hold references, not copies

**Related to check:** Value types, inout, struct vs class

</details>

---

### Pattern Matching

**Q:** What pattern matching capabilities does Swift have? Give examples.

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift's pattern matching goes beyond switch—it works with if case, for case, and in assignments. You can match enums, tuples, types, ranges, and use where clauses.

**Key points:**
- switch: exhaustive for enums; pattern matching in cases
- if case / guard case: match a single pattern
- for case: filter while iterating
- Patterns: enum cases, tuples, type casting (is, as), optional (?, nil), ranges

**Related to check:** Enums, optionals, switch, control flow

</details>

---

### Subscripts

**Q:** What are subscripts in Swift? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Subscripts provide shortcut syntax for accessing elements of a collection, list, or sequence. Use subscript notation (e.g. array[0]) instead of calling a method.

**Key points:**
- Use subscript keyword; can be read-only or read-write
- Can take multiple parameters
- Used by Array, Dictionary, String
- Overload by parameter type

**Related to check:** Collections, Key paths, Custom types

</details>

---

### Key Paths

**Q:** What are key paths in Swift? How do you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Key paths are a way to reference a property of a type without invoking it. They're used for KVO, SwiftUI bindings, and functional-style property access.

**Key points:**
- KeyPath<Root, Value>
- Use backslash Type.property syntax
- KeyPath vs WritableKeyPath
- Use with map for property access

**Related to check:** map, Property wrappers, SwiftUI bindings, KVO

</details>

---

### Protocol Composition

**Q:** What is protocol composition? How does it differ from inheritance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Protocol composition combines multiple protocols with '&'. A type can conform to ProtocolA & ProtocolB without a single protocol inheriting from both.

**Key points:**
- Use & to combine: Encodable & Decodable
- No inheritance hierarchy
- Use for constrained generics
- AnyObject for class-only

**Related to check:** Protocols, Generics, Inheritance

</details>

---

### Self vs self

**Q:** What's the difference between Self and self in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** self refers to the current instance. Self (capital S) refers to the type of the current context—the conforming type in a protocol or the class/struct itself.

**Key points:**
- self: instance
- Self: type
- Self in protocol = conforming type
- Self in return types

**Related to check:** Protocols, Static, Type identity

</details>

---

### Copy-on-Write

**Q:** What is copy-on-write? How does Swift use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Copy-on-write (COW) defers copying until a mutation occurs. Swift's Array, Dictionary, and Set use COW so that assignment is cheap until you modify.

**Key points:**
- Assignment doesn't copy immediately
- Copy happens on first mutation
- Value semantics with performance
- Custom COW with isKnownUniquelyReferenced

**Related to check:** Value types, Struct vs class, Memory

</details>

---

### Ranges

**Q:** How do ranges work in Swift? Explain closed, half-open, and one-sided ranges.

<details>
<summary>Reveal answer</summary>

**Short answer:** Ranges represent intervals. ClosedRange (a...b) includes both ends. Range (a..<b) excludes the upper bound. One-sided ranges (a...) go to the end.

**Key points:**
- ClosedRange: 1...5
- Range: 1..<5
- One-sided: 2...
- Used in subscript, for-in, switch

**Related to check:** Collections, Subscripts, for-in, Pattern matching

</details>

---

### Sequence and IteratorProtocol

**Q:** What are Sequence and IteratorProtocol? How do they relate?

<details>
<summary>Reveal answer</summary>

**Short answer:** Sequence provides sequential access to elements. IteratorProtocol is the underlying protocol that produces elements one at a time. Sequence has an associated Iterator.

**Key points:**
- Sequence: makeIterator()
- IteratorProtocol: next()
- for-in uses Sequence
- Lazy sequences

**Related to check:** Sequence, for-in, Collections

</details>

---

### Optional map and flatMap

**Q:** How do map and flatMap work on Optional?

<details>
<summary>Reveal answer</summary>

**Short answer:** Optional.map transforms the wrapped value if non-nil; returns nil if nil. Optional.flatMap transforms and can return nil to flatten nested optionals.

**Key points:**
- map: (T) -> U
- flatMap: (T) -> U?
- Use map for transform
- Use flatMap when transform returns optional

**Related to check:** map, flatMap, compactMap, Optional chaining

</details>

---

### Autoclosure

**Q:** What is @autoclosure? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** @autoclosure wraps an expression in a closure so it's not evaluated until the closure is called. Used for short-circuit evaluation (e.g. assert, ??).

**Key points:**
- Delays evaluation
- Used in assert, ??
- Can capture without executing
- Use sparingly

**Related to check:** Closures, Nil coalescing, Lazy evaluation

</details>

---

### String Interpolation

**Q:** How does string interpolation work in Swift? Can you customize it?

<details>
<summary>Reveal answer</summary>

**Short answer:** String interpolation uses \(expression) in a string literal. Conform to CustomStringConvertible or use StringInterpolation for custom formatting.

**Key points:**
- \(expr) in strings
- CustomStringConvertible
- String.StringInterpolation
- ExpressibleByStringInterpolation

**Related to check:** CustomStringConvertible, String, Formatting

</details>

---

### Custom Operators

**Q:** How do you define custom operators in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Declare with operator keyword. Define precedence and associativity. Implement as a static function. Use sparingly for domain-specific DSLs.

**Key points:**
- operator keyword
- prefix, infix, postfix
- precedencegroup
- Keep readable

**Related to check:** Operator overloading, precedencegroup

</details>

---

### Lazy Collections

**Q:** What are lazy collections? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Lazy collections defer computation until elements are accessed. Use .lazy to chain transforms without creating intermediate arrays.

**Key points:**
- .lazy property
- Deferred evaluation
- Use for long chains
- Memory efficient

**Related to check:** map, filter, Sequence, IteratorProtocol

</details>

---

### @MainActor Basics

**Q:** What is @MainActor? When do you need it?

<details>
<summary>Reveal answer</summary>

**Short answer:** @MainActor isolates code to the main thread. Use it for UI updates, main-thread-only APIs, or types that must always run on the main queue.

**Key points:**
- Isolates to main thread
- UI code
- Mark types or functions
- await for cross-actor calls

**Related to check:** Actors, Main thread, await

</details>

---

### Capture Lists

**Q:** What are capture lists in closures? When do you need them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Capture lists specify how values are captured: [weak self], [unowned self], or [x, y] to capture copies. Use them to avoid retain cycles and control capture semantics.

**Key points:**
- [weak self] breaks cycles
- [unowned self] when lifetime guaranteed
- [x] captures copy
- Default is strong capture

**Related to check:** weak vs unowned, Retain cycles, Closures and escaping

</details>

---

### Never Type

**Q:** What is the Never type? When is it used?

<details>
<summary>Reveal answer</summary>

**Short answer:** Never is an uninhabited type—no value of type Never exists. Used for functions that never return (fatalError, infinite loops) or exhaustive switches.

**Key points:**
- Uninhabited type
- fatalError returns Never
- Exhaustive switch
- Result<Success, Never>

**Related to check:** Result type, fatalError, Error handling

</details>

---

### Dynamic Member Lookup

**Q:** What is @dynamicMemberLookup? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** @dynamicMemberLookup allows subscript-style access to members by string. Used for dynamic languages, JSON wrappers, or SwiftUI's @dynamicMemberLookup environment.

**Key points:**
- subscript(dynamicMember:)
- String-based access
- Type-safe variants
- Use for dynamic data

**Related to check:** Key paths, Subscripts, SwiftUI Environment

</details>

---

### Property Observers

**Q:** What are willSet and didSet? How do they differ from computed properties?

<details>
<summary>Reveal answer</summary>

**Short answer:** willSet and didSet observe changes to stored properties. willSet runs before the new value is set; didSet runs after. They're for side effects, not computation.

**Key points:**
- willSet, didSet
- Stored properties only
- oldValue, newValue
- Don't use for derived values

**Related to check:** Computed properties, Property wrappers, KVO

</details>

---

### Nested Types

**Q:** When would you use nested types in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Nested types keep related types together and avoid polluting the global namespace. Use for type-specific enums, errors, or implementation details.

**Key points:**
- Type.Type for nesting
- Scoped to outer type
- Use for related types
- CodingKeys pattern

**Related to check:** Codable, Enums, Access control

</details>

---

### Availability Checking

**Q:** How do you check API availability in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use #available or @available to conditionally compile or run code based on OS version. Prevents crashes when using APIs not available on older systems.

**Key points:**
- #available in if/guard
- @available on declarations
- Platform and version
- Fallback for older OS

**Related to check:** @available, Deployment target, Backward compatibility

</details>

---

## UIKit & Views

### View Lifecycle

**Q:** Explain the UIViewController and UIView lifecycle. What methods are called and when?

<details>
<summary>Reveal answer</summary>

**Short answer:** The lifecycle starts when the view controller is created and progresses through load, appear, layout, and disappear phases. Key methods: loadView, viewDidLoad, viewWillAppear, viewDidAppear, viewWillDisappear, viewDidDisappear.

**Key points:**
- loadView: creates the view (don't override unless building view programmatically)
- viewDidLoad: view loaded, good for one-time setup
- viewWillAppear/viewDidAppear: before/after view is on screen
- viewWillDisappear/viewDidDisappear: before/after view leaves screen
- viewDidLayoutSubviews: after layout pass, for frame-dependent setup

**Related to check:** Auto Layout, view hierarchy, present vs push

</details>

---

### Auto Layout

**Q:** How does Auto Layout work? What are constraints and how do you create them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Auto Layout is a constraint-based system that determines view positions and sizes at runtime. Constraints define relationships between views (e.g., leading, trailing, width) and the system solves them to satisfy the layout.

**Key points:**
- Constraints are linear equations: view1.attr = view2.attr * multiplier + constant
- Each view needs enough constraints to avoid ambiguity (position + size)
- Content hugging and compression resistance affect intrinsic size
- Layout engine runs when constraints change; updates frames

**Related to check:** Stack views, intrinsic content size, layout margins

</details>

---

### UITableView vs UICollectionView

**Q:** When would you use UITableView vs UICollectionView?

<details>
<summary>Reveal answer</summary>

**Short answer:** UITableView displays a single-column list with built-in styles. UICollectionView is more flexible—grids, custom layouts, multiple sections with different layouts. Use TableView for lists; CollectionView when you need grids or custom layouts.

**Key points:**
- TableView: single column, built-in styles (plain, grouped), simpler API
- CollectionView: flow layout (grid), custom layouts, compositional layout (iOS 13+)
- Both use cell reuse for performance
- CollectionView requires a layout object; TableView has built-in layout

**Related to check:** Cell reuse, diffable data source, compositional layout

</details>

---

### Cell Reuse

**Q:** How does cell reuse work in UITableView/UICollectionView? Why is it important?

<details>
<summary>Reveal answer</summary>

**Short answer:** Cells are reused from a pool instead of creating new ones for each row. When a cell scrolls off screen, it goes to the reuse queue. When a new cell is needed, one is dequeued and configured. This keeps memory low and scrolling smooth.

**Key points:**
- dequeueReusableCell(withIdentifier:for:) gets a cell from the pool or creates one
- Only visible cells exist in memory; scrolling reuses them
- Must configure cell in cellForRow/cellForItem—cells are reused with old content
- Register cell class or nib before dequeuing

**Related to check:** UITableView, UICollectionView, performance

</details>

---

### Safe Area

**Q:** What is the safe area? Why is it important?

<details>
<summary>Reveal answer</summary>

**Short answer:** The safe area defines the region of the screen not obscured by system UI—status bar, notch, home indicator, rounded corners. Content should stay within it to avoid being hidden or overlapping system elements.

**Key points:**
- safeAreaLayoutGuide provides layout anchors for the safe region
- Insets change with device (notch vs non-notch), orientation, split view
- Use safeAreaInsets or safeAreaLayoutGuide for constraints
- Additional safe area insets for custom overlays (e.g., keyboard)

**Related to check:** Auto Layout, layout margins, device variants

</details>

---

### UIStackView

**Q:** What is UIStackView? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIStackView arranges views in a row or column with automatic layout. It manages constraints for you—spacing, alignment, distribution—and adapts when views are added or removed.

**Key points:**
- axis: horizontal or vertical
- distribution: fill, fillEqually, fillProportionally, equalSpacing, equalCentering
- alignment: fill, leading, center, trailing
- spacing between arranged subviews
- Can nest stack views for complex layouts

**Related to check:** Auto Layout, intrinsic content size, layout

</details>

---

### Responder Chain

**Q:** What is the responder chain? How does it work?

<details>
<summary>Reveal answer</summary>

**Short answer:** The responder chain is a linked list of UIResponder objects (views, view controllers, app delegate) that can handle events. When a responder doesn't handle an event, it passes to nextResponder until someone does or the chain ends.

**Key points:**
- Starts at first responder (e.g., tapped view), goes up the view hierarchy
- Then to view controller, window, application
- Used for: touch events, motion events, key commands, actions (target-action)
- hitTest:withEvent: determines first responder for touches

**Related to check:** UIResponder, hit testing, touch handling

</details>

---

### Hit Testing

**Q:** How does hit testing work? Explain hitTest(_:with:) and point(inside:with:).

<details>
<summary>Reveal answer</summary>

**Short answer:** Hit testing finds which view should receive a touch. point(inside:with:) checks if a point is inside the view's bounds. hitTest walks the view hierarchy from back to front, using point(inside:) to find the deepest subview containing the point.

**Key points:**
- point(inside:with:): returns Bool, is point in bounds?
- hitTest(_:with:): returns the frontmost view containing the point, or nil
- Order: reverse subview order (front views first)
- Skips hidden views, userInteractionEnabled = false, alpha = 0

**Related to check:** Responder chain, touch handling, view hierarchy

</details>

---

### Storyboards vs Programmatic UI

**Q:** What are the tradeoffs between Storyboards and programmatic UI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Storyboards offer visual design and segues; programmatic UI is code-only. Storyboards can cause merge conflicts and slow load times; programmatic gives full control and better diffs. Many teams use programmatic for complex apps.

**Key points:**
- Storyboards: WYSIWYG, segues, IBOutlets, merge conflicts in large teams
- Programmatic: full control, no XML conflicts, testable, steeper learning curve
- XIBs: single-view middle ground
- SwiftUI is replacing both for new code

**Related to check:** Auto Layout, view lifecycle, SwiftUI

</details>

---

### Size Classes

**Q:** What are size classes? How do you use them for adaptive layout?

<details>
<summary>Reveal answer</summary>

**Short answer:** Size classes are abstract traits (compact or regular) for horizontal and vertical dimensions. They describe the available space (e.g., iPhone portrait: compact width, regular height; iPad: regular both). Use them to adapt layouts across devices and orientations.

**Key points:**
- Horizontal and vertical each: compact or regular
- iPhone: varies by orientation and model (e.g., Plus/Max can be regular width)
- iPad: typically regular/regular; split view changes them
- Override traitCollectionDidChange to react to changes

**Related to check:** Trait collections, adaptive layout, iPad

</details>

---

### Constraint Priority

**Q:** What is constraint priority? When would you change it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Priority (0-1000) determines which constraints break when the layout system can't satisfy all of them. Required is 1000; lower priorities break first. Use it for optional constraints or flexible layouts.

**Key points:**
- 1000 = required (default); cannot be broken
- Lower = more likely to break when there's conflict
- Common: 999 for "almost required", 750-250 for optional
- System breaks lower priority constraints to satisfy required ones

**Related to check:** Auto Layout, intrinsic content size, layout engine

</details>

---

### Layout Cycle

**Q:** Explain the layout cycle. When does layout happen?

<details>
<summary>Reveal answer</summary>

**Short answer:** The layout cycle updates view frames based on constraints. It's triggered by changes (constraints, bounds, setNeedsLayout). The system batches updates and runs layout in the next run loop pass.

**Key points:**
- setNeedsLayout: marks view dirty, layout in next cycle
- layoutIfNeeded: forces immediate layout (use when you need frames now)
- layoutSubviews: override to do custom layout (rare with Auto Layout)
- Order: update constraints → layout (frames) → display

**Related to check:** Auto Layout, setNeedsDisplay, draw cycle

</details>

---

### Diffable Data Source

**Q:** What is UICollectionViewDiffableDataSource / UITableViewDiffableDataSource? How does it differ from the traditional data source?

<details>
<summary>Reveal answer</summary>

**Short answer:** Diffable data source uses snapshots of data and automatically computes diffs to animate insertions, deletions, and moves. The data source is the single source of truth; you apply snapshots instead of reloading.

**Key points:**
- Section and item types must be Hashable
- NSDiffableDataSourceSnapshot describes current state
- apply(snapshot) animates changes automatically
- No more numberOfSections, numberOfRows, cellForRow—it's declarative

**Related to check:** UITableView, UICollectionView, Hashable

</details>

---

### UIScrollView Delegate

**Q:** What does UIScrollViewDelegate do? What are the key methods?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIScrollViewDelegate notifies about scrolling, zooming, and dragging. Key methods: scrollViewDidScroll for position, scrollViewWillBeginDragging/scrollViewDidEndDragging for user interaction, scrollViewDidScrollToTop for tap-to-top.

**Key points:**
- scrollViewDidScroll: called frequently during scroll (throttle heavy work)
- scrollViewWillBeginDragging / scrollViewDidEndDecelerating: user started/stopped
- viewForZooming: return view to zoom
- scrollViewDidScrollToTop: when user taps status bar

**Related to check:** UIScrollView, content offset, content size

</details>

---

### Present vs Push

**Q:** What's the difference between presenting and pushing a view controller?

<details>
<summary>Reveal answer</summary>

**Short answer:** Push adds a view controller to a navigation stack (requires UINavigationController). Present modally shows a view controller on top, with its own presentation style. Push is for drill-down flows; present for modals, sheets, forms.

**Key points:**
- Push: navigationController.pushViewController; back button, swipe back
- Present: present(_:animated:); modal, pageSheet, formSheet, fullScreen
- Present can have its own navigation stack
- Dismiss vs pop for returning

**Related to check:** UINavigationController, modal presentation, dismiss

</details>

---

### View Controller Containment

**Q:** What is view controller containment? How do you add a child view controller?

<details>
<summary>Reveal answer</summary>

**Short answer:** Containment embeds one view controller inside another. You add the child, add its view as a subview, and set up constraints. The parent manages the child's lifecycle. Used for split views, tabs, custom containers.

**Key points:**
- addChild, addSubview, didMove(toParent:)
- removeFromParent, willMove(toParent: nil) for removal
- Child receives lifecycle events (viewWillAppear, etc.)
- Parent must add child's view and constrain it

**Related to check:** View hierarchy, lifecycle, custom containers

</details>

---

### Gesture Recognizers

**Q:** How do gesture recognizers work? What types are available?

<details>
<summary>Reveal answer</summary>

**Short answer:** Gesture recognizers interpret touch sequences into gestures (tap, pinch, pan, etc.). They're attached to views and have targets/actions. They abstract raw touches into semantic gestures.

**Key points:**
- UITapGestureRecognizer, UIPanGestureRecognizer, UIPinchGestureRecognizer, UIRotationGestureRecognizer, UISwipeGestureRecognizer, UILongPressGestureRecognizer
- Add to view: view.addGestureRecognizer(tap)
- State: .possible, .began, .changed, .ended, .cancelled
- delegate for simultaneous recognition, requiring failure

**Related to check:** Touch handling, responder chain, hit testing

</details>

---

### Animations

**Q:** How do you animate in UIKit? What options are available?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIKit offers UIView.animate for simple animations, and UIViewPropertyAnimator for interactive/controllable animations. You can animate animatable properties (frame, alpha, transform) and constraint changes.

**Key points:**
- UIView.animate: duration, delay, options, completion
- Animate: frame, bounds, center, transform, alpha
- For constraints: change constant, call layoutIfNeeded in animation block
- UIViewPropertyAnimator: pause, reverse, fractionComplete for scrubbing

**Related to check:** Core Animation, CALayer, transform

</details>

---

### Intrinsic Content Size

**Q:** What is intrinsic content size? How does it affect Auto Layout?

<details>
<summary>Reveal answer</summary>

**Short answer:** Intrinsic content size is the natural size a view wants to be based on its content—e.g., UILabel from text, UIImageView from image. Auto Layout uses it when constraints don't fully determine size.

**Key points:**
- Content hugging: resists growing larger than intrinsic size
- Compression resistance: resists shrinking smaller than intrinsic size
- UIView.noIntrinsicMetric (-1) for views without intrinsic size
- Custom views override intrinsicContentSize

**Related to check:** Auto Layout, content hugging, compression resistance

</details>

---

### TableView Prefetching

**Q:** What is prefetching in UITableView? How does it improve performance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Prefetching notifies the data source before cells are about to become visible. You can start loading data (images, etc.) in advance so cells are ready when they scroll into view. Reduces perceived lag.

**Key points:**
- UITableViewDataSourcePrefetching protocol
- prefetchRows(at: [IndexPath]) — called before rows appear
- cancelPrefetching(for: [IndexPath]) — rows scrolled away
- Use for async loading (images, network)

**Related to check:** Cell reuse, UITableView, performance

</details>

---

### IBOutlet weak vs strong

**Q:** Should IBOutlets be weak or strong? Why?

<details>
<summary>Reveal answer</summary>

**Short answer:** Top-level objects in a nib (e.g., root view) are typically strong; subviews are typically weak. The view hierarchy holds strong references to subviews, so the outlet can be weak to avoid a retain cycle. But it's nuanced—Apple's default is strong for subviews in modern Xcode.

**Key points:**
- Strong: outlet owns the reference; view survives as long as VC
- Weak: subview is retained by superview; outlet avoids cycle
- Root view in nib: typically strong (nothing else owns it)
- Subviews: weak or strong both work; strong is safer if view is removed from hierarchy

**Related to check:** Retain cycles, view hierarchy, nib loading

</details>

---

### CALayer vs UIView

**Q:** What's the difference between CALayer and UIView? When would you use CALayer directly?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIView is a higher-level wrapper around CALayer. Every UIView has a backing layer. CALayer is for rendering (geometry, animation); UIView adds touch handling, layout, and hierarchy. Use CALayer when you need lightweight rendering without UIView overhead.

**Key points:**
- UIView: responder, layout, constraints, touches
- CALayer: position, bounds, transform, animations, corner radius, etc.
- UIView.layer gives access to the backing layer
- Use CALayer for: particles, decorations, performance-critical views

**Related to check:** Core Animation, rendering, view hierarchy

</details>

---

### Keyboard Handling

**Q:** How do you handle the keyboard in UIKit? What are the key considerations?

<details>
<summary>Reveal answer</summary>

**Short answer:** Observe keyboard notifications (willShow, willHide, didShow, didHide) to get frame and animation duration. Adjust content insets or scroll view position so the focused field stays visible. Use inputAccessoryView for a toolbar above the keyboard.

**Key points:**
- UIResponder.keyboardFrameEndUserInfoKey, UIResponder.keyboardAnimationDurationUserInfoKey
- Adjust scroll view contentInset or scrollRectToVisible
- Animate with keyboard's duration for smooth sync
- Dismiss: tap outside, or resignFirstResponder

**Related to check:** First responder, scroll view, UITextField

</details>

---

### Rotation and Orientation

**Q:** How do you handle device rotation and orientation changes?

<details>
<summary>Reveal answer</summary>

**Short answer:** Override supportedInterfaceOrientations to control allowed orientations. Use traitCollectionDidChange or viewWillTransition to react to layout changes. The system notifies before and after rotation.

**Key points:**
- supportedInterfaceOrientations: which orientations are allowed
- viewWillTransition(to:with:): before rotation, coordinator for animation
- traitCollectionDidChange: when traits (size class, etc.) change
- Info.plist: UISupportedInterfaceOrientations

**Related to check:** Trait collections, size classes, layout

</details>

---

### UICollectionViewCompositionalLayout

**Q:** What is UICollectionViewCompositionalLayout? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Compositional layout is a declarative, flexible layout system for UICollectionView (iOS 13+). You define sections with items, groups, and nested groups. It supports grids, lists, custom layouts, and adaptive designs without subclassing UICollectionViewLayout.

**Key points:**
- NSCollectionLayoutSection, NSCollectionLayoutGroup, NSCollectionLayoutItem
- Groups can be horizontal, vertical, or custom
- Supports estimated sizes, orthogonal scrolling, pinned headers
- Replaces custom layout subclasses for most cases

**Related to check:** UICollectionView, diffable data source, NSCollectionLayout

</details>

---

### Draw Cycle

**Q:** What's the difference between layout and draw? When does each happen?

<details>
<summary>Reveal answer</summary>

**Short answer:** Layout determines frames (where views are). Draw renders pixels (what they look like). Layout uses constraints; draw uses draw(_:) or layer contents. setNeedsLayout triggers layout; setNeedsDisplay triggers draw.

**Key points:**
- Layout: layoutSubviews, constraints, frames
- Draw: draw(_:), layer.contents, Core Graphics
- Layout happens when constraints/bounds change
- Draw happens when content needs to be rendered

**Related to check:** Layout cycle, CALayer, Core Graphics

</details>

---

### View Hierarchy

**Q:** How does the view hierarchy work? What's the relationship between superview, subviews, and the window?

<details>
<summary>Reveal answer</summary>

**Short answer:** Views form a tree: UIWindow is root, view controllers' views are added to it, subviews are added to views. The hierarchy determines drawing order (back to front), hit testing, and layout. addSubview adds; removeFromSuperview removes.

**Key points:**
- UIWindow → root view controller's view → subviews
- subviews array order = back to front (last = front)
- insertSubview(_:at:), insertSubview(_:aboveSubview:), etc.
- Layout flows from parent to children (typically)

**Related to check:** Auto Layout, view lifecycle, window

</details>

---

### Segues

**Q:** What are segues? How do they work with Storyboards?

<details>
<summary>Reveal answer</summary>

**Short answer:** Segues define transitions between view controllers in storyboards. They're triggered by user action (button tap) or programmatically with performSegue. prepare(for:sender:) is where you pass data to the destination.

**Key points:**
- show: push (if in nav) or present
- showDetail: replace in split view or present
- presentModally, presentAsPopover
- prepare(for:sender:) — configure destination before transition

**Related to check:** Storyboards, view controller lifecycle, navigation

</details>

---

### UICollectionView List Configuration

**Q:** How do you create a list with UICollectionView in iOS 14+?

<details>
<summary>Reveal answer</summary>

**Short answer:** UICollectionViewListConfiguration creates a list-style layout (like UITableView) with UICollectionView. Supports headers, swipe actions, outlines, and works with diffable data source. It's the modern way to build lists in UIKit.

**Key points:**
- UICollectionViewListConfiguration for list appearance
- UICollectionLayoutListConfiguration
- Supports: grouped, insetGrouped, sidebar
- Cell content configurations (UIListContentConfiguration)
- Swipe actions, accessories

**Related to check:** Diffable data source, compositional layout

</details>

---

### Memory Warnings

**Q:** How do you handle memory warnings in a view controller?

<details>
<summary>Reveal answer</summary>

**Short answer:** Override didReceiveMemoryWarning (or use sceneDidEnterBackgroundNotification). Release cached data, images, and non-essential resources. The system may terminate the app if memory isn't freed.

**Key points:**
- didReceiveMemoryWarning called when system is low on memory
- Release: caches, large images, temporary data
- Don't release: UI that's visible, critical data
- System may purge view controller views (viewWillUnload removed in iOS 6)

**Related to check:** ARC, caching, NSCache

</details>

---

### UIRefreshControl

**Q:** How do you implement pull-to-refresh in UITableView?

<details>
<summary>Reveal answer</summary>

**Short answer:** Add UIRefreshControl to the table view's refreshControl. Handle the valueChanged event to trigger a reload.

**Key points:**
- refreshControl property
- addTarget or async
- endRefreshing when done
- Works with UICollectionView

**Related to check:** ScrollView content insets, CollectionView prefetching, Diffable data source

</details>

---

### UIContextMenuInteraction

**Q:** How do you add context menus to views?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use UIContextMenuInteraction with a delegate. Return UIMenu with UIActions. iOS 13+.

**Key points:**
- UIContextMenuInteraction
- contextMenuInteraction delegate
- UIMenu, UIAction
- Preview with UIContextMenuContentPreviewProvider

**Related to check:** UIGestureRecognizer delegate, UIControl target-action, UIRefreshControl

</details>

---

### UIPageViewController

**Q:** When would you use UIPageViewController?

<details>
<summary>Reveal answer</summary>

**Short answer:** For swipeable page-based navigation (onboarding, image gallery). Provides page curl or scroll style.

**Key points:**
- Data source protocol
- View controller array
- Page curl vs scroll
- Transition style

**Related to check:** UIViewController transitions, UICollectionView, UIScrollView

</details>

---

### Dynamic Type

**Q:** How do you support Dynamic Type in UIKit?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use preferredFont(forTextStyle:), adjust fonts for content size category. Support accessibility text sizes.

**Key points:**
- UIFont.preferredFont
- contentSizeCategory
- traitCollection
- Invalidate on change

**Related to check:** Accessibility, UITraitCollection, UILabel vs UITextView

</details>

---

### UISplitViewController

**Q:** How does UISplitViewController work on iPad?

<details>
<summary>Reveal answer</summary>

**Short answer:** Master-detail with primary and secondary. Collapses to navigation on iPhone. displayModeButtonItem for show/hide.

**Key points:**
- primary/secondary
- collapsed on compact
- displayMode
- UISplitViewControllerDelegate

**Related to check:** UITraitCollection, UIScene multi-window, UINavigationBar customization

</details>

---

### UICollectionViewDiffableDataSource

**Q:** How does DiffableDataSource differ from traditional data source?

<details>
<summary>Reveal answer</summary>

**Short answer:** Uses snapshots; animates changes automatically. No manual reloadData. Hashable items for identity.

**Key points:**
- NSDiffableDataSourceSnapshot
- apply(snapshot)
- Hashable identifiers
- Automatic animations

**Related to check:** CollectionView prefetching, Custom collection view layout, UITableView

</details>

---

### UIScrollView Content Insets

**Q:** How do content insets affect UIScontentScrollView?

<details>
<summary>Reveal answer</summary>

**Short answer:** Content insets add padding; content stays scrollable. Used for safe area, keyboard, refresh control.

**Key points:**
- contentInset
- adjustedContentInset
- automaticallyAdjustsScrollIndicatorInsets
- Safe area integration

**Related to check:** UIRefreshControl, Safe area, UILabel vs UITextView

</details>

---

### View Debugging

**Q:** How do you debug view layout issues in Xcode?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use View Debugger (Debug menu). Capture hierarchy, inspect constraints and frames. Compare expected vs actual.

**Key points:**
- Debug View Hierarchy
- 3D view
- Constraints
- Frames

**Related to check:** ScrollView content insets, Auto Layout, Accessibility

</details>

---

### UILabel vs UITextView

**Q:** When would you use UITextView instead of UILabel?

<details>
<summary>Reveal answer</summary>

**Short answer:** UITextView for editable text, long text with scrolling, or rich text. UILabel for static, single-line or simple multi-line.

**Key points:**
- Editable vs static
- Scrollable
- Data detectors
- Performance

**Related to check:** Dynamic Type, ScrollView content insets, Accessibility

</details>

---

### Custom UICollectionViewLayout

**Q:** When would you create a custom UICollectionViewLayout?

<details>
<summary>Reveal answer</summary>

**Short answer:** When compositional layout or flow layout don't fit. Custom layouts for unique arrangements (e.g. circular, masonry).

**Key points:**
- layoutAttributesForElements
- prepare()
- invalidateLayout
- Subclass UICollectionViewLayout

**Related to check:** UICollectionView prefetching, Diffable data source, View debugging

</details>

---

### UIApplication Lifecycle

**Q:** What are the main UIApplication lifecycle events?

<details>
<summary>Reveal answer</summary>

**Short answer:** applicationDidFinishLaunching, will/didBecomeActive, will/didResignActive, will/didEnterBackground, willTerminate.

**Key points:**
- Scene vs App lifecycle
- Background transitions
- State restoration
- iOS 13+ scenes

**Related to check:** UIScene multi-window, State restoration, Memory warning handling

</details>

---

### UITraitCollection

**Q:** What is UITraitCollection? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Describes the current environment: size class, display scale, color scheme. Check for adaptive layout.

**Key points:**
- horizontalSizeClass
- verticalSizeClass
- userInterfaceStyle
- traitCollectionDidChange

**Related to check:** UISplitViewController, Dynamic Type, UINavigationBar customization

</details>

---

### UINavigationBar Customization

**Q:** How do you customize UINavigationBar appearance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use UINavigationBarAppearance (iOS 13+). Configure for standard, scrollEdge, compact. Apply to bar.

**Key points:**
- UINavigationBarAppearance
- configureWithOpaqueBackground
- scrollEdgeAppearance
- Appearance API

**Related to check:** UITraitCollection, UIViewController transitions, Dynamic Type

</details>

---

### UIControl and Target-Action

**Q:** How does the target-action pattern work with UIControl?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIControl subclasses (UIButton, etc.) use addTarget:action:forControlEvents. Action is a method selector.

**Key points:**
- addTarget
- @objc for selectors
- Control events
- Touch up inside

**Related to check:** UIGestureRecognizer delegate, UIContextMenuInteraction, Closure-based APIs

</details>

---

### UIGestureRecognizerDelegate

**Q:** When do you need UIGestureRecognizerDelegate?

<details>
<summary>Reveal answer</summary>

**Short answer:** For simultaneous recognition, requiring failure, or custom hit testing. gestureRecognizer:shouldRecognizeSimultaneouslyWith.

**Key points:**
- shouldRecognizeSimultaneously
- shouldRequireFailureOf
- shouldReceive
- Hit testing

**Related to check:** UIControl target-action, UIContextMenuInteraction, Hit testing

</details>

---

### UIView Animations

**Q:** How do you animate UIView properties?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIView.animate(withDuration:animations:). Or animateKeyframes, transition, spring. Set animatable properties in block.

**Key points:**
- animate(withDuration:)
- animations block
- completion
- Spring animations

**Related to check:** UIViewController transitions, CATransaction, CADisplayLink

</details>

---

### UICollectionView Prefetching

**Q:** How does prefetching work in UICollectionView?

<details>
<summary>Reveal answer</summary>

**Short answer:** UICollectionViewDataSourcePrefetching. prefetchItemsAt index paths. Cancel when cells go off-screen.

**Key points:**
- prefetchDataSource
- prefetchItemsAt
- cancelPrefetchingForItemsAt
- Async loading

**Related to check:** Diffable data source, Image downsampling, Lazy loading strategy

</details>

---

### UIViewController Transitions

**Q:** How do you create custom view controller transitions?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate. Present or push with custom animator.

**Key points:**
- UIViewControllerAnimatedTransitioning
- transitionDuration
- animateTransition
- Interactive transitions

**Related to check:** UIView animations, UINavigationBar customization, UIPageViewController

</details>

---

### UIScene and Multi-Window

**Q:** How does UIScene support multiple windows on iPad?

<details>
<summary>Reveal answer</summary>

**Short answer:** UISceneSession, UIWindowScene. Each scene has its own window. Configure in Info.plist and scene delegate.

**Key points:**
- UISceneSession
- UIWindowScene
- Scene configuration
- Multiple windows

**Related to check:** UIApplication lifecycle, UISplitViewController, State restoration

</details>

---

### Accessibility in UIKit

**Q:** How do you make UIKit views accessible?

<details>
<summary>Reveal answer</summary>

**Short answer:** accessibilityLabel, accessibilityHint, accessibilityTraits. VoiceOver reads label and hint. Support Dynamic Type.

**Key points:**
- accessibilityLabel
- accessibilityHint
- accessibilityTraits
- isAccessibilityElement

**Related to check:** Dynamic Type, UITraitCollection, View debugging

</details>

---

## SwiftUI

### @State, @Binding, @ObservedObject

**Q:** Explain @State, @Binding, and @ObservedObject. When would you use each?

<details>
<summary>Reveal answer</summary>

**Short answer:** @State is for view-owned mutable state. @Binding passes a two-way connection to state owned elsewhere. @ObservedObject is for reference types (ObservableObject) that the view observes for changes.

**Key points:**
- @State: value type, owned by view, triggers view update on change
- @Binding: reference to parent's state; changes propagate both ways
- @ObservedObject: observes external object; view updates when it publishes
- @State for private view state; @ObservedObject for shared model

**Related to check:** @StateObject, @EnvironmentObject, ObservableObject

</details>

---

### @StateObject vs @ObservedObject

**Q:** What's the difference between @StateObject and @ObservedObject?

<details>
<summary>Reveal answer</summary>

**Short answer:** @StateObject owns the object's lifecycle; SwiftUI won't recreate it when the view re-renders. @ObservedObject doesn't own—it assumes the parent will inject it. Use @StateObject when the view creates the object; @ObservedObject when it receives it.

**Key points:**
- @StateObject: view owns it; survives view updates
- @ObservedObject: view doesn't own; parent provides
- If you use @ObservedObject for a created object, it can be recreated on body re-evaluation (bug)
- @StateObject ensures single instance per view identity

**Related to check:** @State, @ObservedObject, ObservableObject, view identity

</details>

---

### View Lifecycle

**Q:** What's the view lifecycle in SwiftUI? How does it differ from UIKit?

<details>
<summary>Reveal answer</summary>

**Short answer:** SwiftUI doesn't have explicit lifecycle methods like viewDidLoad. Views are created when needed and recreated when state changes. Use .onAppear, .onDisappear, .task for lifecycle events. The body is a function of state—it's recomputed when state changes.

**Key points:**
- body is computed; not a stored property
- .onAppear: when view appears (like viewDidAppear)
- .onDisappear: when view leaves
- .task: async work that cancels on disappear
- No viewDidLoad equivalent; init runs when view is created

**Related to check:** @State, .task, view identity, body

</details>

---

### body as Computed Property

**Q:** Why is body a computed property in SwiftUI? What are the implications?

<details>
<summary>Reveal answer</summary>

**Short answer:** body is computed every time SwiftUI needs to render the view. It's a function of state—when @State, @ObservedObject, etc. change, body is re-evaluated. This keeps the view declarative: you describe what it looks like for given state.

**Key points:**
- Not stored; recomputed on state change
- Must be pure and fast—no side effects
- SwiftUI diffs the result and updates only what changed
- Expensive work in body can cause performance issues

**Related to check:** @State, view updates, declarative UI

</details>

---

### ObservableObject and @Published

**Q:** How do ObservableObject and @Published work together?

<details>
<summary>Reveal answer</summary>

**Short answer:** ObservableObject is a protocol for classes that publish changes. @Published marks properties that trigger objectWillChange when modified. SwiftUI observes the object and re-renders views when @Published properties change.

**Key points:**
- ObservableObject conforms to AnyObject (class only)
- @Published wraps a property; changes trigger view update
- objectWillChange sends before change; SwiftUI subscribes
- Use for ViewModels, shared state

**Related to check:** @StateObject, @ObservedObject, Combine

</details>

---

### Optional Binding

**Q:** How do you handle optional values and binding in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use optional binding with if let, Optional.map for binding, or Binding.constant for read-only. For optional @State, use optional binding in the view or provide a default with ??.

**Key points:**
- if let unwraps for view body
- Binding<T?> can be unwrapped with Binding.optional or custom
- Optional($state) when state is Optional
- Use .sheet(item:) for optional-driven presentation

**Related to check:** @State, @Binding, Identifiable

</details>

---

### NavigationStack and Navigation

**Q:** How does navigation work in SwiftUI? Explain NavigationStack and NavigationLink.

<details>
<summary>Reveal answer</summary>

**Short answer:** NavigationStack (iOS 16+) is the container for navigation; NavigationLink pushes views onto the stack. Use NavigationLink with value for type-safe navigation with NavigationPath. NavigationView is deprecated.

**Key points:**
- NavigationStack holds the navigation state
- NavigationLink(destination:) or NavigationLink(value:) with navigationDestination
- NavigationPath for type-erased programmatic navigation
- Toolbar for bar button items

**Related to check:** NavigationLink, toolbar, navigationDestination

</details>

---

### Sheets and fullScreenCover

**Q:** How do you present sheets and full-screen modals in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .sheet or .fullScreenCover with a binding to a boolean or optional. When the binding is true/non-nil, the modal is presented. Set binding to false/nil to dismiss.

**Key points:**
- .sheet(isPresented:content:) or .sheet(item:content:)
- .fullScreenCover for full-screen modals
- Binding controls presentation
- Use @Environment(\.dismiss) in presented view to dismiss

**Related to check:** @State, @Binding, presentationDetents

</details>

---

### @EnvironmentObject

**Q:** What is @EnvironmentObject? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** @EnvironmentObject injects an ObservableObject from the environment. A parent provides it with .environmentObject(); descendants access it without passing through every level. Use for app-wide or subtree-wide shared state.

**Key points:**
- Injected at root or any ancestor
- No need to pass through intermediate views
- Crashes if not provided (ensure .environmentObject at root)
- Use for: auth state, theme, app settings

**Related to check:** @ObservedObject, @Environment, dependency injection

</details>

---

### GeometryReader

**Q:** What is GeometryReader? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** GeometryReader provides the size and position of its container. It expands to fill available space. Use it when you need to layout based on dimensions—e.g., proportional sizing, custom layouts, or passing size to children.

**Key points:**
- geometry.size, geometry.safeAreaInsets
- geometry.frame(in: .local) or .global
- Expands to fill space (can cause layout issues)
- Often used with overlay/background to avoid affecting layout

**Related to check:** PreferenceKey, layout, frames

</details>

---

### Combine Integration

**Q:** How does SwiftUI integrate with Combine?

<details>
<summary>Reveal answer</summary>

**Short answer:** SwiftUI uses Combine under the hood. ObservableObject uses objectWillChange (a Combine subject). @Published is a property wrapper that publishes changes. You can use .sink, .assign, or async/await with publishers.

**Key points:**
- ObservableObject emits via objectWillChange
- .onReceive(publisher) to react to publishers in views
- Combine publishers can drive @State via .sink
- async/await often replaces Combine for async flows

**Related to check:** ObservableObject, async/await, publishers

</details>

---

### Modifier Order

**Q:** Does modifier order matter in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Yes. Modifiers wrap the view in a new view; order affects the result. .padding().background() adds padding then wraps in a background. .background().padding() wraps in background then adds padding—the background extends under the padding.

**Key points:**
- Each modifier returns a modified view
- .padding() then .background(): background inside padding
- .background() then .padding(): padding outside background
- Order affects: layout, hit testing, animations

**Related to check:** ViewBuilder, View protocol, layout

</details>

---

### @MainActor

**Q:** What is @MainActor in SwiftUI? Why is it important?

<details>
<summary>Reveal answer</summary>

**Short answer:** MainActor ensures code runs on the main thread. UI updates must happen on main. SwiftUI views and ObservableObjects that update UI should be @MainActor. It's part of Swift's structured concurrency.

**Key points:**
- UI must be updated on main thread
- @MainActor on class or function
- ViewModel with @Published should be @MainActor
- MainActor.run { } to hop to main from background

**Related to check:** Concurrency, async/await, actors

</details>

---

### Identifiable

**Q:** What is Identifiable? When do you need it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Identifiable requires an id property. SwiftUI uses it for list identity—to track which items changed for animations and diffing. Required for List, ForEach with dynamic data, and .sheet(item:).

**Key points:**
- protocol Identifiable { var id: Self.ID { get } }
- ID must be Hashable
- Used by ForEach, List, navigationDestination, sheet(item:)
- Stable ids improve animation and performance

**Related to check:** ForEach, List, Hashable

</details>

---

### PreferenceKey

**Q:** What is PreferenceKey? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** PreferenceKey lets child views pass data up to ancestors. The child sets a preference; the ancestor reads it with .onPreferenceChange. Used for: reading child sizes, aggregating data from descendants, custom layout.

**Key points:**
- protocol PreferenceKey { static var defaultValue; static func reduce }
- reduce combines values from multiple children
- .preference(key:value:) sets; .onPreferenceChange reads
- Often used with GeometryReader to pass size up

**Related to check:** GeometryReader, layout, view hierarchy

</details>

---

### @ViewBuilder

**Q:** What is @ViewBuilder? How does it work?

<details>
<summary>Reveal answer</summary>

**Short answer:** ViewBuilder is a result builder that constructs a View from a closure. It allows multiple views without explicit return, supports if/else, and handles optional views. Used in body, Group, VStack, and custom container APIs.

**Key points:**
- Result builder (formerly function builder)
- Enables trailing closure syntax with multiple views
- Supports if, if let, switch (limited)
- Each branch must return same View type (or use Group/AnyView)

**Related to check:** Result builders, some View, View protocol

</details>

---

### ScrollView vs List

**Q:** When would you use ScrollView vs List?

<details>
<summary>Reveal answer</summary>

**Short answer:** List is for data-driven, repeating rows with built-in styling, selection, and swipe actions. ScrollView is for custom scrollable content—any layout. List uses lazy loading; ScrollView loads all content by default (use LazyVStack for lazy).

**Key points:**
- List: rows, styling, swipe actions, selection, lazy
- ScrollView: arbitrary content, no built-in row behavior
- List has platform-appropriate styling (grouped, inset)
- LazyVStack/LazyHStack in ScrollView for lazy loading

**Related to check:** ForEach, LazyVStack, performance

</details>

---

### Animations

**Q:** How do you animate in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .animation() modifier or withAnimation { }. When state changes inside the closure, SwiftUI animates the transition. .animation(.easeInOut, value: state) ties animation to specific state. transition() controls how views appear/disappear.

**Key points:**
- withAnimation { state = newValue }
- .animation(.easeInOut, value: count)
- .transition(.opacity) for appearance
- Implicit vs explicit animation

**Related to check:** @State, transition, Animation

</details>

---

### UIViewRepresentable

**Q:** How do you use UIKit views in SwiftUI? What is UIViewRepresentable?

<details>
<summary>Reveal answer</summary>

**Short answer:** UIViewRepresentable wraps a UIView for use in SwiftUI. Implement makeUIView and updateUIView. makeUIView creates the view; updateUIView updates it when SwiftUI state changes. Use Coordinator for delegate/data source.

**Key points:**
- makeUIView(context:) -> UIView
- updateUIView(_:context:) for state updates
- Coordinator for delegates, callbacks
- context.coordinator, context.environment

**Related to check:** UIViewControllerRepresentable, SwiftUI-UIKit bridge

</details>

---

### @Environment

**Q:** What is @Environment? How do you read and set environment values?

<details>
<summary>Reveal answer</summary>

**Short answer:** @Environment reads values from the environment—system-provided (dismiss, colorScheme) or custom. Use @Environment(\\.keyPath) to read. Use .environment(\\.key, value) to set. Environment flows down the view hierarchy.

**Key points:**
- @Environment(\.dismiss), @Environment(\.colorScheme)
- Custom: EnvironmentKey + extension
- .environment(\.key, value) to inject
- Values override down the tree

**Related to check:** @EnvironmentObject, EnvironmentKey, view hierarchy

</details>

---

### .task Modifier

**Q:** What does the .task modifier do? How does it differ from .onAppear?

<details>
<summary>Reveal answer</summary>

**Short answer:** .task runs async work when the view appears and automatically cancels when the view disappears. .onAppear runs sync (or you'd need Task {}). Use .task for async data loading; it handles cancellation.

**Key points:**
- .task { await loadData() }
- Cancels when view disappears
- Can take an id: .task(id: item.id) { } to re-run when id changes
- Replaces .onAppear { Task { } } for async

**Related to check:** async/await, .onAppear, Task

</details>

---

### Custom Layout (Layout Protocol)

**Q:** How do you create custom layouts in SwiftUI? What is the Layout protocol?

<details>
<summary>Reveal answer</summary>

**Short answer:** Layout protocol (iOS 16+) lets you build custom layout containers. Implement sizeThatFits and placeSubviews. You receive proposed sizes and return placement for each subview. Replaces GeometryReader hacks for custom layouts.

**Key points:**
- protocol Layout: sizeThatFits, placeSubviews
- Proposed size from parent; subviews' sizes from layout
- LayoutStack, LayoutThatFits for composition
- Replaces custom View with GeometryReader

**Related to check:** Layout protocol, GeometryReader, View

</details>

---

### Alert and confirmationDialog

**Q:** How do you show alerts and confirmation dialogs in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .alert for alerts and .confirmationDialog for action sheets. Both take a binding to an optional that triggers presentation. .alert for simple messages; .confirmationDialog for multiple actions.

**Key points:**
- .alert(isPresented:content:) or .alert(item:content:)
- .confirmationDialog for action sheet style
- Binding controls presentation
- title, message, buttons

**Related to check:** @State, @Binding, presentation

</details>

---

### AttributedString and Text

**Q:** How do you display formatted or attributed text in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use Text with String for plain text. AttributedString (iOS 15+) supports inline formatting—bold, color, links. Use + to concatenate. Markdown in Text (iOS 15+) for simple formatting. For complex attributed strings, use Text with AttributedString.

**Key points:**
- Text("**Bold** and *italic*") — Markdown
- var attr = AttributedString("Hello"); attr.font = .bold
- Text(attr) or Text(attr1 + attr2)
- Link in AttributedString

**Related to check:** Text, Markdown, localization

</details>

---

### Toolbar

**Q:** How do you add toolbar items in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .toolbar { } with ToolbarItem or ToolbarItemGroup. Specify placement: .primaryAction, .cancellationAction, .navigationBarLeading, .bottomBar, etc. Toolbar adapts to context (e.g., compact vs regular).

**Key points:**
- .toolbar { ToolbarItem(placement: .primaryAction) { Button(...) } }
- ToolbarItemGroup for multiple items
- .principal for title
- .keyboard for keyboard accessory

**Related to check:** NavigationStack, NavigationLink

</details>

---

### Forms and Controls

**Q:** What is a Form in SwiftUI? How do you use it for settings-style UIs?

<details>
<summary>Reveal answer</summary>

**Short answer:** Form groups controls with platform-appropriate styling (grouped list on iOS). Use Form { } with TextField, Toggle, Picker, etc. Sections organize content. Form provides automatic styling and layout.

**Key points:**
- Form { Section { ... } }
- TextField, Toggle, Picker, Slider, Stepper
- @FocusState for keyboard management
- Form uses List under the hood

**Related to check:** @State, @Binding, Picker, Toggle

</details>

---

### View Identity

**Q:** What is view identity in SwiftUI? Why does it matter?

<details>
<summary>Reveal answer</summary>

**Short answer:** View identity determines whether SwiftUI treats a view as the same or different across updates. Same identity preserves state (@State, @StateObject). Different identity recreates the view. Use .id() to explicitly set identity.

**Key points:**
- Structural identity: position in view tree
- Explicit identity: .id(value)
- When identity changes, view is recreated—state is lost
- if/else branches have different identities

**Related to check:** @State, @StateObject, body

</details>

---

### Lazy Loading

**Q:** How do you implement lazy loading in SwiftUI? LazyVStack vs VStack?

<details>
<summary>Reveal answer</summary>

**Short answer:** LazyVStack/LazyHStack/LazyVGrid create views only when they're about to appear (like UITableView cell reuse). VStack creates all views immediately. Use Lazy* for long lists; use regular stacks for small, fixed content.

**Key points:**
- LazyVStack: views created on demand
- VStack: all views created at once
- List is lazy by default
- ScrollView + LazyVStack for custom lazy lists

**Related to check:** ScrollView, List, ForEach, performance

</details>

---

### Accessibility

**Q:** How do you make SwiftUI views accessible?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .accessibilityLabel, .accessibilityHint, .accessibilityValue for VoiceOver. .accessibilityAddTraits for roles. .accessibilityElement(children:) to combine or ignore. SwiftUI provides defaults; override when needed.

**Key points:**
- Label: what it is
- Hint: what happens when activated
- Value: current state (e.g., slider value)
- Traits: .isButton, .isHeader, .isSelected

**Related to check:** VoiceOver, accessibility traits, UIKit accessibility

</details>

---

### PreviewProvider

**Q:** How do you create SwiftUI previews? What is PreviewProvider?

<details>
<summary>Reveal answer</summary>

**Short answer:** PreviewProvider provides previews for the canvas. Implement static var previews: some View. Use #Preview macro (Xcode 15+) or PreviewProvider protocol. Inject sample data, different states, multiple devices.

**Key points:**
- #Preview { View() } or struct Previews: PreviewProvider
- .previewDisplayName for labels
- .previewDevice for device
- .environmentObject for injected dependencies

**Related to check:** @EnvironmentObject, SwiftUI canvas

</details>

---

### @FocusState

**Q:** How do you manage keyboard focus in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use @FocusState and .focused() modifier. Set binding to move focus between fields. Dismiss keyboard with nil.

**Key points:**
- @FocusState
- .focused()
- Focus binding
- Keyboard dismissal

**Related to check:** ScrollViewReader, ControlGroup, Keyboard avoidance

</details>

---

### @FetchRequest and Core Data

**Q:** How do you integrate Core Data with SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use @FetchRequest in a view. Pass NSManagedObjectContext from environment. FetchedResults auto-updates.

**Key points:**
- @FetchRequest
- @EnvironmentObject for context
- NSPredicate
- Sort descriptors

**Related to check:** SwiftData and SwiftUI, @Observable macro, Table and column

</details>

---

### matchedGeometryEffect

**Q:** What is matchedGeometryEffect? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Animates shared element transitions between views. Give same namespace and id to source and destination.

**Key points:**
- matchedGeometryEffect
- namespace
- id
- Hero-style transitions

**Related to check:** PhaseAnimator, ContentTransition, UIViewController transitions

</details>

---

### Layout Priorities

**Q:** How do layout priorities work in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** layoutPriority() modifier. Higher priority views get space first. Default is 0.

**Key points:**
- layoutPriority
- Fitting vs flexible
- Spacer behavior
- Stack distribution

**Related to check:** Grid, ScaledMetric, ControlGroup

</details>

---

### @AppStorage

**Q:** What is @AppStorage? How does it differ from @State?

<details>
<summary>Reveal answer</summary>

**Short answer:** @AppStorage persists to UserDefaults. Survives app restart. Use for user preferences.

**Key points:**
- @AppStorage
- UserDefaults key
- Persistence
- Simple types

**Related to check:** @State, @Observable macro, SwiftData and SwiftUI

</details>

---

### ScrollViewReader

**Q:** How do you programmatically scroll in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use ScrollViewReader with ScrollViewProxy. Call scrollTo(id) to scroll to a view with that id.

**Key points:**
- ScrollViewReader
- scrollTo
- id modifier
- WithAnimation

**Related to check:** ScrollView content insets, Focus state, List

</details>

---

### @ScaledMetric

**Q:** What is @ScaledMetric? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Scales a value with Dynamic Type. Use for spacing, sizes that should grow with text size.

**Key points:**
- @ScaledMetric
- Dynamic Type
- Accessibility
- Relative sizing

**Related to check:** Dynamic Type, Layout priorities, Canvas drawing

</details>

---

### Canvas and Drawing

**Q:** How do you do custom drawing in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use Canvas or Path. Canvas for Metal-accelerated 2D. Path for vector shapes. Shape protocol.

**Key points:**
- Canvas
- Path
- Shape
- GraphicsContext

**Related to check:** ScaledMetric, Layout priorities, Metal GPU

</details>

---

### Inspector

**Q:** What is the Inspector modifier? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Side panel that shows/hides (e.g. iPad). Use .inspector() for detail or settings alongside main content.

**Key points:**
- inspector
- isPresented
- Sidebar pattern
- iPad

**Related to check:** DocumentGroup, ControlGroup, NavigationSplitView

</details>

---

### Observable Macro

**Q:** What is the @Observable macro? How does it replace ObservableObject?

<details>
<summary>Reveal answer</summary>

**Short answer:** @Observable (iOS 17+) makes properties observable without @Published. Use with @State. Simpler than ObservableObject.

**Key points:**
- @Observable
- @State for observation
- No @Published
- iOS 17+

**Related to check:** @State, ObservableObject, SwiftData and SwiftUI

</details>

---

### ControlGroup and Control

**Q:** What are ControlGroup and Control in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** ControlGroup groups related controls. Control is the protocol for custom controls. Used in toolbar, forms.

**Key points:**
- ControlGroup
- Control protocol
- Toolbar
- Menu style

**Related to check:** Inspector, Focus state, Layout priorities

</details>

---

### ContentTransition

**Q:** How do you animate content changes in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** contentTransition() modifier. .numericText, .symbolEffect for animating value or symbol changes.

**Key points:**
- contentTransition
- numericText
- symbolEffect
- Animated updates

**Related to check:** SymbolEffect, PhaseAnimator, Matched geometry effect

</details>

---

### Table and Column

**Q:** How do you create tables in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Table with TableColumn. Use for column-based data. Supports selection, sorting.

**Key points:**
- Table
- TableColumn
- TableRow
- Selection

**Related to check:** Grid, Fetch request, Diffable data source

</details>

---

### Grid

**Q:** What is the Grid layout? How does it differ from LazyVGrid?

<details>
<summary>Reveal answer</summary>

**Short answer:** Grid is for fixed, small layouts. LazyVGrid is for scrollable content. Grid flows top-to-bottom, left-to-right.

**Key points:**
- Grid
- GridRow
- LazyVGrid
- When to use each

**Related to check:** Table and column, Layout priorities, LazyVStack

</details>

---

### PhaseAnimator

**Q:** What is PhaseAnimator? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Animates through phases. Each phase has its own content and transition. For multi-step animations.

**Key points:**
- PhaseAnimator
- phases
- trigger
- Sequential animation

**Related to check:** ContentTransition, SymbolEffect, Matched geometry effect

</details>

---

### SymbolEffect

**Q:** How do you add effects to SF Symbols?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .symbolEffect() modifier. Bounce, pulse, variableColor. Animate symbol state changes.

**Key points:**
- symbolEffect
- bounce
- pulse
- SF Symbols

**Related to check:** ContentTransition, Sensory feedback, PhaseAnimator

</details>

---

### Sensory Feedback

**Q:** What is sensory feedback in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Haptic and audio feedback. Use .sensoryFeedback() for success, warning, selection. Improves UX.

**Key points:**
- sensoryFeedback
- trigger
- pattern
- Haptics

**Related to check:** SymbolEffect, PhaseAnimator, ContentTransition

</details>

---

### DocumentGroup

**Q:** How do you build document-based apps in SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** DocumentGroup for file-based apps. Defines document type. Handles open, save, export.

**Key points:**
- DocumentGroup
- FileDocument
- ReferenceFileDocument
- Document browser

**Related to check:** WidgetKit integration, @AppStorage, Inspector

</details>

---

### WidgetKit Integration

**Q:** How do you add widgets to a SwiftUI app?

<details>
<summary>Reveal answer</summary>

**Short answer:** WidgetKit extension. TimelineProvider. SwiftUI views for widget content. Configuration for user customization.

**Key points:**
- WidgetKit
- TimelineProvider
- Widget view
- Configuration

**Related to check:** DocumentGroup, @AppStorage, App lifecycle

</details>

---

### SwiftData and SwiftUI

**Q:** How do you use SwiftData with SwiftUI?

<details>
<summary>Reveal answer</summary>

**Short answer:** ModelContainer in environment. @Query for fetching. @Model for model types. SwiftData replaces Core Data for new apps.

**Key points:**
- @Query
- @Model
- ModelContainer
- SwiftData

**Related to check:** @FetchRequest, @Observable macro, @AppStorage

</details>

---

## Architecture

### MVC

**Q:** Explain MVC. What are its strengths and weaknesses on iOS?

<details>
<summary>Reveal answer</summary>

**Short answer:** MVC separates Model (data), View (UI), and Controller (logic). On iOS, the View and Controller are tightly coupled—UIViewController owns the view. Controllers often become massive (Massive View Controller).

**Key points:**
- Model: data and business logic
- View: UI (UIKit/SwiftUI)
- Controller: mediates between model and view
- iOS: ViewController = Controller + View ownership

**Related to check:** MVVM, MVP, VIPER, Coordinator

</details>

---

### MVVM

**Q:** Explain MVVM. How does it improve on MVC?

<details>
<summary>Reveal answer</summary>

**Short answer:** MVVM adds a ViewModel between View and Model. ViewModel exposes data and commands; View binds to it. View has no business logic. Enables testing and reduces ViewController size.

**Key points:**
- ViewModel: presentation logic, state for view
- View: displays ViewModel, sends user actions
- Binding: data flow (Combine, @Published, RxSwift)
- ViewModel is testable without UI

**Related to check:** MVC, Combine, Coordinator, Reactive

</details>

---

### VIPER

**Q:** What is VIPER? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** VIPER: View, Interactor, Presenter, Entity, Router. Each has a single responsibility. Interactor has business logic; Presenter prepares data for View; Router handles navigation. Very structured but verbose.

**Key points:**
- View: displays, sends user actions to Presenter
- Interactor: business logic, data access
- Presenter: mediates View and Interactor
- Entity: model objects
- Router: navigation

**Related to check:** Clean Architecture, MVP, Coordinator

</details>

---

### Coordinator Pattern

**Q:** What is the Coordinator pattern? Why use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Coordinators own navigation flow. ViewControllers don't know about each other—they delegate navigation to a Coordinator. Reduces coupling, centralizes flow logic, enables deep linking.

**Key points:**
- Coordinator: creates VCs, handles navigation
- VC delegates "show detail" to coordinator
- Coordinator holds navigation stack or presents
- Flow logic in one place

**Related to check:** MVVM, Router, navigation

</details>

---

### Dependency Injection

**Q:** What is dependency injection? What are the different types?

<details>
<summary>Reveal answer</summary>

**Short answer:** Dependency injection passes dependencies from outside instead of creating them inside. Types: constructor (init), property, method. Enables testing (mock injection), flexibility, and explicit dependencies.

**Key points:**
- Constructor: init(service: Service)
- Property: var service: Service!
- Method: configure(service: Service)
- Avoids hidden dependencies (singletons, globals)

**Related to check:** Protocols, testing, SOLID

</details>

---

### Repository Pattern

**Q:** What is the Repository pattern? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Repository abstracts data access. The app uses a protocol; implementation can be network, database, cache. Decouples business logic from data source. Enables testing and swapping implementations.

**Key points:**
- protocol UserRepository { func fetch() async throws -> [User] }
- Implementation: NetworkUserRepository, LocalUserRepository
- Single interface for data access
- Can combine sources (cache + network)

**Related to check:** Clean Architecture, dependency injection

</details>

---

### Delegate Pattern

**Q:** Explain the delegate pattern. When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Delegate: one object delegates behavior to another via a protocol. The delegating object holds a weak reference to the delegate. Common in UIKit (UITableViewDelegate). Use for callbacks, customization, one-to-one communication.

**Key points:**
- protocol Delegate: class { func didFinish() }
- weak var delegate: Delegate?
- Delegating object calls delegate methods
- Delegate is usually the owner

**Related to check:** Protocol, weak reference, callback

</details>

---

### NotificationCenter

**Q:** When would you use NotificationCenter vs Delegate vs Closure?

<details>
<summary>Reveal answer</summary>

**Short answer:** NotificationCenter: broadcast, many-to-many, loose coupling. Delegate: one-to-one, tight contract. Closure: inline, captures context. Use NotificationCenter for app-wide events (e.g., logout); delegate for component communication; closure for simple callbacks.

**Key points:**
- NotificationCenter: decoupled, multiple observers
- Delegate: explicit contract, one delegate
- Closure: simple, captures context
- Consider Combine/async for new code

**Related to check:** Delegate, Combine, observer pattern

</details>

---

### Clean Architecture

**Q:** What is Clean Architecture? What are the layers?

<details>
<summary>Reveal answer</summary>

**Short answer:** Clean Architecture (Uncle Bob) separates concerns into layers. Dependencies point inward. Entities (innermost), Use Cases, Interface Adapters, Frameworks (outermost). Business logic is independent of UI and frameworks.

**Key points:**
- Entities: core business objects
- Use Cases: application-specific business rules
- Interface Adapters: presenters, gateways
- Frameworks: UI, DB, network
- Dependency rule: inner layers don't know outer

**Related to check:** SOLID, Repository, VIPER

</details>

---

### SOLID Principles

**Q:** Explain the SOLID principles. How do they apply to iOS?

<details>
<summary>Reveal answer</summary>

**Short answer:** SOLID: Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion. Guide design for maintainability and testability.

**Key points:**
- SRP: One reason to change per class
- OCP: Open for extension, closed for modification
- LSP: Subtypes must be substitutable
- ISP: Many specific interfaces over one general
- DIP: Depend on abstractions, not concretions

**Related to check:** Protocols, dependency injection, OOP

</details>

---

### Protocol-Oriented Architecture

**Q:** How do you design with protocols in iOS architecture?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use protocols to define contracts. Depend on protocols, not concrete types. Enables testing (mocks), flexibility (swap implementations), and composition. Swift's protocol extensions add default behavior.

**Key points:**
- protocol APIProtocol { func fetch() async throws -> Data }
- Inject protocol type
- Mock for tests
- Protocol composition (A & B)

**Related to check:** Dependency injection, testing, Swift protocols

</details>

---

### Use Case / Interactor

**Q:** What is a Use Case? When would you create one?

<details>
<summary>Reveal answer</summary>

**Short answer:** A Use Case encapsulates a single application action (e.g., 'Fetch User Profile'). It orchestrates repositories and returns result. Keeps business logic out of ViewModels. One use case per user action.

**Key points:**
- Single responsibility: one action
- Calls repositories, applies rules
- Returns domain models or DTOs
- Testable in isolation

**Related to check:** Clean Architecture, Repository

</details>

---

### Modular Architecture

**Q:** What is modular architecture? How do you structure an app with modules?

<details>
<summary>Reveal answer</summary>

**Short answer:** Modules are self-contained units (Swift packages, frameworks). Each has clear boundaries and dependencies. Enables team scaling, build times, and reuse. Use Swift Package Manager or Xcode frameworks.

**Key points:**
- Feature modules, core modules, shared
- Dependencies: core ← feature
- Avoid circular dependencies
- Public API per module

**Related to check:** SPM, frameworks, dependency graph

</details>

---

### Red-Green-Refactor

**Q:** What is the Red-Green-Refactor cycle in TDD?

<details>
<summary>Reveal answer</summary>

**Short answer:** TDD cycle: Red (write failing test), Green (minimal code to pass), Refactor (improve without breaking). Ensures tests drive design and code is tested. Repeat for each behavior.

**Key points:**
- Red: test fails
- Green: make it pass, minimal change
- Refactor: clean up, keep green
- Fast feedback loop

**Related to check:** TDD, unit testing, design

</details>

---

### Feature Flags

**Q:** How would you implement feature flags? What are the considerations?

<details>
<summary>Reveal answer</summary>

**Short answer:** Feature flags toggle features at runtime. Can be remote (server) or local. Use for: gradual rollout, A/B testing, kill switch. Store flag state; check before showing feature.

**Key points:**
- Remote config (Firebase, custom API)
- Local override for dev
- Caching for offline
- User/segment-based flags

**Related to check:** Remote config, A/B testing

</details>

---

### Error Handling Architecture

**Q:** How do you structure error handling across layers?

<details>
<summary>Reveal answer</summary>

**Short answer:** Define domain errors; map infrastructure errors to them. Repository throws domain errors; ViewModel maps to user-facing messages. Use Result or throws. Centralize error types.

**Key points:**
- Domain errors: UserNotFound, NetworkError
- Map API errors to domain
- ViewModel: domain → user message
- Don't leak infrastructure errors to UI

**Related to check:** Result, throws, layers

</details>

---

### Offline-First

**Q:** How do you design an offline-first app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Local data is source of truth; network syncs when available. Cache locally (Core Data, SQLite); queue mutations; sync in background. Show cached data immediately; update when sync completes.

**Key points:**
- Local DB as primary
- Queue writes when offline
- Sync when online
- Conflict resolution

**Related to check:** Core Data, sync, caching

</details>

---

### State Management

**Q:** How do you manage app state? What approaches are there?

<details>
<summary>Reveal answer</summary>

**Short answer:** State: data that drives UI. Approaches: local (@State), shared (ObservableObject, @EnvironmentObject), global (Redux-like). Choose based on scope: view, screen, app.

**Key points:**
- Local: @State, @StateObject
- Shared: @ObservedObject, @EnvironmentObject
- Unidirectional: State → View, Action → Reducer
- Single source of truth

**Related to check:** @State, ObservableObject, Redux

</details>

---

### Navigation Architecture

**Q:** How do you structure navigation in a large app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use Coordinator or Router to own navigation. ViewControllers/Views don't navigate—they delegate. Centralizes flow logic, enables deep linking, testable. Each flow has a coordinator.

**Key points:**
- Coordinator/Router owns navigation
- VC emits intent (e.g., showDetail)
- Coordinator creates and presents
- Child coordinators for sub-flows

**Related to check:** Coordinator, Router, deep linking

</details>

---

### Caching Strategy

**Q:** How do you design a caching layer?

<details>
<summary>Reveal answer</summary>

**Short answer:** Cache stores data for faster access. Strategies: cache-aside (check cache, load on miss), write-through (write to cache and source), TTL (expire after time). Use NSCache for memory; disk for persistence.

**Key points:**
- Memory: NSCache (auto-evicts)
- Disk: FileManager, Core Data
- TTL, invalidation
- Cache key design

**Related to check:** NSCache, persistence, performance

</details>

---

### ViewModel Design

**Q:** How do you design a ViewModel? What should it contain?

<details>
<summary>Reveal answer</summary>

**Short answer:** ViewModel prepares data for the view. It has: state (@Published), actions (methods), and dependencies (services). No UI types. Testable. Transforms model to view state.

**Key points:**
- State: what view displays
- Actions: user intents
- Dependencies: repositories, use cases
- No UIKit/SwiftUI types

**Related to check:** MVVM, ObservableObject, testing

</details>

---

### Deep Linking

**Q:** How do you implement deep linking?

<details>
<summary>Reveal answer</summary>

**Short answer:** Deep linking opens a specific screen via URL. Handle in AppDelegate/SceneDelegate (application:openURL) or onOpenURL. Parse URL, map to route, Coordinator navigates. Support Universal Links and custom URL scheme.

**Key points:**
- URL scheme: myapp://detail/123
- Universal Links: https://app.com/detail/123
- Parse → Route → Coordinator
- Restore navigation stack

**Related to check:** Coordinator, URL schemes

</details>

---

### App Lifecycle

**Q:** How does the app lifecycle affect architecture?

<details>
<summary>Reveal answer</summary>

**Short answer:** App goes through states: not running, inactive, active, background, suspended. Handle in AppDelegate/SceneDelegate. Save state when entering background; restore on launch. Design for termination and restoration.

**Key points:**
- applicationWillResignActive, didEnterBackground
- applicationWillTerminate
- State restoration
- Scene-based lifecycle (multi-window)

**Related to check:** State restoration, SceneDelegate

</details>

---

### Analytics Architecture

**Q:** How do you integrate analytics without coupling?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use a protocol for analytics; inject implementation. ViewModels/Views call analytics.track(event). Implementation can be Firebase, Mixpanel, etc. Decouples from specific SDK.

**Key points:**
- protocol AnalyticsService { func track(_ event: Event) }
- Inject into ViewModels
- No analytics types in business logic
- Easy to swap or mock

**Related to check:** Dependency injection, protocols

</details>

---

### Logging Architecture

**Q:** How do you structure logging in an app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use a logging protocol; inject implementation. Levels: debug, info, warning, error. Use os.log or third-party. Centralize; avoid print in production. Consider log aggregation.

**Key points:**
- protocol Logger { func log(_ message: String, level: Level) }
- Inject into services
- Configurable per build (debug vs release)
- Structured logging (metadata)

**Related to check:** os.log, dependency injection

</details>

---

### Config Management

**Q:** How do you manage configuration (API URLs, keys) across environments?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use build configurations (Debug, Release, Staging). xcconfig or plist per environment. Inject at build time. Never commit secrets; use environment variables or secure storage.

**Key points:**
- Debug, Release, Staging configs
- xcconfig for build settings
- Info.plist for per-env values
- Secrets: Keychain, env vars

**Related to check:** Build configurations, CI/CD

</details>

---

### Design Systems

**Q:** How do you implement a design system in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Design system: shared components, tokens (colors, typography, spacing). Create a module or package. Use SwiftUI View modifiers, UIKit extensions. Document usage. Single source for design decisions.

**Key points:**
- Tokens: colors, fonts, spacing
- Components: Button, Card, etc.
- Theming support
- Documentation

**Related to check:** Components, theming, accessibility

</details>

---

### Backward Compatibility

**Q:** How do you maintain backward compatibility when changing APIs?

<details>
<summary>Reveal answer</summary>

**Short answer:** Version APIs; deprecate rather than remove. Use @available for new APIs. Support multiple versions during transition. Document migration. Consider server-driven compatibility.

**Key points:**
- Deprecation warnings
- @available(iOS 15, *)
- Fallbacks for older OS
- API versioning

**Related to check:** @available, deployment target

</details>

---

### Code Organization

**Q:** How do you organize code in a large iOS project?

<details>
<summary>Reveal answer</summary>

**Short answer:** Organize by feature or layer. Feature: group View, ViewModel, models together. Layer: all ViewModels, all Views. Use folders, groups, or modules. Consistent naming. Co-locate related code.

**Key points:**
- Feature-based: Auth/, Feed/, Profile/
- Layer-based: Views/, ViewModels/, Models/
- Shared: Core/, Extensions/
- Clear boundaries

**Related to check:** Modular architecture, folders

</details>

---

### Service Locator vs DI

**Q:** What's the difference between Service Locator and Dependency Injection?

<details>
<summary>Reveal answer</summary>

**Short answer:** Service Locator: global registry; components ask for dependencies. DI: dependencies passed in. Service Locator hides dependencies; DI makes them explicit. Prefer DI for testability and clarity.

**Key points:**
- Service Locator: ServiceLocator.shared.get(API.self)
- DI: init(api: API)
- Locator: implicit, global
- DI: explicit, testable

**Related to check:** Dependency injection, testing

</details>

---

### Event-Driven Architecture

**Q:** What is event-driven architecture? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Components communicate via events. Loose coupling. Use for real-time updates, decoupled modules.

**Key points:**
- Event bus
- Publish-subscribe
- Loose coupling
- Trade-offs

**Related to check:** Event sourcing, CQRS, Combine

</details>

---

### CQRS

**Q:** What is CQRS? How does it apply to mobile?

<details>
<summary>Reveal answer</summary>

**Short answer:** Command Query Responsibility Segregation. Separate read and write models. Use when reads and writes have different needs.

**Key points:**
- Commands vs queries
- Separate models
- Event sourcing
- When to use

**Related to check:** Event sourcing, Saga pattern, BFF

</details>

---

### Hexagonal Architecture

**Q:** What is hexagonal (ports and adapters) architecture?

<details>
<summary>Reveal answer</summary>

**Short answer:** Core logic in center. Ports define interfaces. Adapters implement for UI, DB, network. Dependency inversion.

**Key points:**
- Ports
- Adapters
- Dependency rule
- Testability

**Related to check:** Dependency graph, CQRS, SOLID principles

</details>

---

### BFF (Backend for Frontend)

**Q:** What is a BFF? When would an iOS app use one?

<details>
<summary>Reveal answer</summary>

**Short answer:** Backend for Frontend. API tailored to mobile. Aggregates, transforms. Reduces round trips.

**Key points:**
- Mobile-specific API
- Aggregation
- When to use
- vs direct API

**Related to check:** GraphQL client, API versioning, Request deduplication

</details>

---

### Event Sourcing

**Q:** What is event sourcing? When would you consider it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Store events, not state. Replay to derive state. Audit trail, time travel. Complex; use when needed.

**Key points:**
- Event store
- Replay
- Audit
- Complexity

**Related to check:** CQRS, Saga pattern, Event-driven architecture

</details>

---

### Saga Pattern

**Q:** What is the Saga pattern? When is it used?

<details>
<summary>Reveal answer</summary>

**Short answer:** Orchestrates distributed transactions. Compensating actions on failure. Use for multi-step workflows.

**Key points:**
- Compensation
- Orchestration
- Distributed
- When to use

**Related to check:** Event sourcing, CQRS, Event-driven architecture

</details>

---

### API Versioning Strategy

**Q:** How do you version your API for mobile clients?

<details>
<summary>Reveal answer</summary>

**Short answer:** URL path, headers, or content negotiation. Support multiple versions during migration. Deprecation policy.

**Key points:**
- Version in URL
- Header
- Backward compatibility
- Deprecation

**Related to check:** API documentation, Content negotiation, Migration strategy

</details>

---

### Circuit Breaker

**Q:** What is the circuit breaker pattern? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Stops calling failing service. Opens after threshold. Half-open to retry. Prevents cascade failures.

**Key points:**
- Open, closed, half-open
- Failure threshold
- Recovery
- Resilience

**Related to check:** Bulkhead pattern, API rate limiting, Retry strategies

</details>

---

### Bulkhead Pattern

**Q:** What is the bulkhead pattern?

<details>
<summary>Reveal answer</summary>

**Short answer:** Isolate resources. Failure in one pool doesn't affect others. Like ship bulkheads.

**Key points:**
- Resource pools
- Isolation
- Concurrency limits
- Resilience

**Related to check:** Circuit breaker, API rate limiting, Task priority

</details>

---

### Health Checks

**Q:** How do you implement health checks in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Endpoint or flag. Check dependencies (network, auth, DB). Report to monitoring. Startup and runtime.

**Key points:**
- Startup check
- Liveness
- Readiness
- Monitoring

**Related to check:** Circuit breaker, Migration strategy, Crash reporting

</details>

---

### Feature Toggles

**Q:** How do feature flags differ from feature toggles?

<details>
<summary>Reveal answer</summary>

**Short answer:** Often used interchangeably. Toggles can be runtime; flags often build-time. Both control feature visibility.

**Key points:**
- Runtime vs build
- Remote config
- Gradual rollout
- Cleanup

**Related to check:** A/B testing architecture, Migration strategy, Health checks

</details>

---

### A/B Testing Architecture

**Q:** How do you architect A/B testing in an app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Remote config or SDK. Assign variant. Track events. Analyze. Don't block app on experiment fetch.

**Key points:**
- Variant assignment
- Remote config
- Event tracking
- Fallback

**Related to check:** Feature toggles, Analytics events, Remote config

</details>

---

### Secrets Management

**Q:** How do you manage secrets in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Never commit. Use env vars, Keychain, or remote config. Obfuscation helps but isn't security.

**Key points:**
- Keychain
- Build config
- Remote
- Security

**Related to check:** Certificate pinning, OAuth 2.0 flow, Request signing

</details>

---

### Localization Architecture

**Q:** How do you structure an app for localization?

<details>
<summary>Reveal answer</summary>

**Short answer:** String catalogs, NSLocalizedString. Avoid concatenation. RTL support. Pluralization.

**Key points:**
- String catalogs
- Localizable.strings
- Pluralization
- RTL

**Related to check:** Dynamic Type, UITraitCollection, Build configuration

</details>

---

### Crash Reporting Integration

**Q:** How do you integrate crash reporting?

<details>
<summary>Reveal answer</summary>

**Short answer:** SDK (e.g. Firebase Crashlytics). Symbolicate. Upload dSYMs. Group and prioritize.

**Key points:**
- dSYM upload
- Symbolication
- Grouping
- Alerts

**Related to check:** Symbolication, Analytics events, Logging levels

</details>

---

### Analytics Events

**Q:** How do you structure analytics events?

<details>
<summary>Reveal answer</summary>

**Short answer:** Consistent naming. Event schema. Batch and flush. Don't block main thread.

**Key points:**
- Event schema
- Naming
- Batching
- Privacy

**Related to check:** Crash reporting, Logging levels, A/B testing architecture

</details>

---

### Logging Levels

**Q:** What logging levels do you use? When?

<details>
<summary>Reveal answer</summary>

**Short answer:** Debug, info, warning, error. Debug in dev only. Info for key events. Error for failures.

**Key points:**
- Levels
- Environment
- Sampling
- Storage

**Related to check:** Crash reporting, Request-response logging, Analytics events

</details>

---

### Dependency Graph

**Q:** How do you visualize and manage dependencies?

<details>
<summary>Reveal answer</summary>

**Short answer:** Tools (e.g. Swift Package Graph). Avoid cycles. Layer architecture. Document.

**Key points:**
- Acyclic
- Layers
- Tools
- Documentation

**Related to check:** Hexagonal architecture, Migration strategy, SOLID principles

</details>

---

### Migration Strategy

**Q:** How do you migrate to a new architecture?

<details>
<summary>Reveal answer</summary>

**Short answer:** Strangler fig. Incremental. Feature flags. Parallel run. Rollback plan.

**Key points:**
- Incremental
- Feature flags
- Rollback
- Testing

**Related to check:** Feature toggles, Dependency graph, Health checks

</details>

---

## Networking

### URLSession

**Q:** How do you use URLSession for networking? What are the key APIs?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSession is the primary API for HTTP. Use dataTask for requests. Shared session for simple cases; custom URLSessionConfiguration for caching, timeouts. Use async/await (data(from:)) or completion handlers.

**Key points:**
- URLSession.shared or custom
- dataTask, uploadTask, downloadTask
- URLSessionConfiguration: timeout, cache policy
- async/await: URLSession.shared.data(from: url)

**Related to check:** Codable, async/await, HTTP

</details>

---

### Codable and JSON

**Q:** How do you decode JSON with Codable? What about custom key mapping?

<details>
<summary>Reveal answer</summary>

**Short answer:** Conform to Codable; use JSONDecoder().decode. Use CodingKeys for snake_case to camelCase. Custom init(from:) for complex parsing. Set dateDecodingStrategy for dates.

**Key points:**
- JSONDecoder().decode(Type.self, from: data)
- CodingKeys enum for key mapping
- init(from decoder: Decoder) for custom
- dateDecodingStrategy

**Related to check:** Codable, JSONDecoder, CodingKeys

</details>

---

### REST API Design

**Q:** How do you structure a REST API client in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Create an APIClient with base URL, use Endpoint enum or protocol for routes. Use async/await or Combine. Centralize error handling, auth, logging. Use URLRequest for configuration.

**Key points:**
- Base URL + path
- Endpoint enum or struct
- Request building
- Response handling, errors

**Related to check:** URLSession, Codable, dependency injection

</details>

---

### Error Handling

**Q:** How do you handle networking errors?

<details>
<summary>Reveal answer</summary>

**Short answer:** Check HTTP status code, handle URLError (no connection, timeout). Map to domain errors. Present user-friendly messages. Use Result or throws. Retry for transient errors.

**Key points:**
- (data, response) from URLSession
- Check (response as? HTTPURLResponse)?.statusCode
- URLError for network failures
- Map to app errors

**Related to check:** Result, throws, URLError

</details>

---

### Authentication

**Q:** How do you handle authentication in API requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Add auth to requests: Bearer token in Authorization header, or URLSessionConfiguration.credentials. Store token securely (Keychain). Refresh when expired. Use URLSessionDelegate for challenge.

**Key points:**
- Authorization: Bearer <token>
- Keychain for storage
- Refresh token flow
- 401 handling, retry with new token

**Related to check:** Keychain, OAuth, headers

</details>

---

### Caching Policy

**Q:** How does HTTP caching work with URLSession?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSession uses URLCache. Set cache policy on request (useProtocolCachePolicy, returnCacheDataElseLoad, reloadIgnoringLocalCacheData). Cache stores responses; respects Cache-Control headers.

**Key points:**
- URLCache (memory + disk)
- URLRequest.cachePolicy
- Cache-Control, ETag
- Invalidate when needed

**Related to check:** URLCache, HTTP, Cache-Control

</details>

---

### Background Downloads

**Q:** How do you implement background downloads?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use URLSessionConfiguration.background(withIdentifier:). Create URLSession with this config. Use downloadTask. Implement URLSessionDelegate for completion. App can be suspended; system continues download.

**Key points:**
- background(withIdentifier:)
- downloadTask
- handleEventsForBackgroundURLSession
- Completion handler in AppDelegate

**Related to check:** URLSession, AppDelegate, background

</details>

---

### Alamofire vs URLSession

**Q:** When would you use Alamofire over URLSession?

<details>
<summary>Reveal answer</summary>

**Short answer:** Alamofire provides convenience: request building, response validation, retry, upload progress. URLSession is built-in, no dependency. Use Alamofire for complex needs; URLSession for simple. Both support async/await.

**Key points:**
- Alamofire: AF.request, validation, retry
- URLSession: native, lightweight
- Both async/await
- Dependency tradeoff

**Related to check:** URLSession, async/await

</details>

---

### SSL Pinning

**Q:** What is SSL pinning? How do you implement it?

<details>
<summary>Reveal answer</summary>

**Short answer:** SSL pinning trusts specific certificates or public keys instead of the system CA. Prevents MITM when CA is compromised. Implement URLSessionDelegate didReceive challenge. Compare server certificate with pinned.

**Key points:**
- Pin certificate or public key
- URLSessionDelegate.urlSession(_:didReceive:completionHandler:)
- Compare SecTrust
- Backup pin for rotation

**Related to check:** Security, certificates, URLSessionDelegate

</details>

---

### Retry Logic

**Q:** How do you implement retry logic for failed requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Retry on transient failures: timeout, 5xx, network error. Use exponential backoff. Limit retries. Don't retry 4xx (client error). Implement with loop or recursive call.

**Key points:**
- Retry: timeout, 503, connection lost
- Don't retry: 400, 401, 404
- Backoff: 1s, 2s, 4s
- Max retries (e.g., 3)

**Related to check:** Error handling, async/await

</details>

---

### Request Cancellation

**Q:** How do you cancel in-flight network requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSessionTask has cancel(). Store task reference, call cancel() when needed (e.g., user navigates away). With async/await, use Task and task.cancel(); the await will throw CancellationError.

**Key points:**
- task.cancel()
- Task cancellation propagates
- CancellationError
- Cancel when view disappears

**Related to check:** Task, URLSessionTask, cancellation

</details>

---

### Upload and Download Progress

**Q:** How do you track upload/download progress?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use URLSessionTaskDelegate. uploadTask with request; implement urlSession(_:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend). For download: didWriteData. Calculate progress: sent/total. Update UI on main thread.

**Key points:**
- URLSessionTaskDelegate
- didSendBodyData for upload
- didWriteData for download
- Progress = bytes/total

**Related to check:** URLSessionDelegate, progress

</details>

---

### Combine and Networking

**Q:** How do you use Combine with networking?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use dataTaskPublisher or wrap URLSession in a publisher. Map to decode. Use .receive(on: DispatchQueue.main) for UI. Handle errors with mapError. Chain with flatMap, retry.

**Key points:**
- URLSession.shared.dataTaskPublisher(for:)
- .decode(type:decoder:)
- .receive(on:)
- .retry(), .mapError()

**Related to check:** Combine, URLSession, publishers

</details>

---

### Mocking for Tests

**Q:** How do you mock networking for unit tests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use a protocol for the API client. Inject mock that returns predefined data or errors. Use URLProtocol to mock URLSession. Or use a test double that returns Result/async values.

**Key points:**
- protocol APIClient { func fetch() async throws -> User }
- MockAPIClient returns test data
- URLProtocol for request-level mock
- Inject into ViewModel

**Related to check:** Dependency injection, testing, protocols

</details>

---

### URLComponents and URL Building

**Q:** How do you safely build URLs with query parameters?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use URLComponents to build URLs. Set scheme, host, path, queryItems. Handles encoding. Avoid string concatenation—it can break with special characters.

**Key points:**
- var components = URLComponents()
- components.scheme, .host, .path
- components.queryItems = [URLQueryItem(name: "q", value: "swift")]
- components.url

**Related to check:** URL, encoding, HTTP

</details>

---

### HTTP Headers

**Q:** What HTTP headers should you set for API requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Common: Content-Type (application/json), Accept, Authorization (Bearer token), User-Agent. Set via URLRequest.setValue. Server may require specific headers. Custom headers for API version, etc.

**Key points:**
- Content-Type: application/json
- Accept: application/json
- Authorization: Bearer <token>
- User-Agent, custom headers

**Related to check:** HTTP, REST, authentication

</details>

---

### Timeout Configuration

**Q:** How do you configure request timeouts?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSessionConfiguration has timeoutIntervalForRequest (total) and timeoutIntervalForResource (full transfer). Default 60s. Set per session or per request. Short for quick APIs; longer for uploads.

**Key points:**
- timeoutIntervalForRequest
- timeoutIntervalForResource
- URLSessionConfiguration
- Per-request: URLRequest.timeoutInterval

**Related to check:** URLSession, URLError.timedOut

</details>

---

### App Transport Security

**Q:** What is App Transport Security (ATS)? When would you disable it?

<details>
<summary>Reveal answer</summary>

**Short answer:** ATS enforces HTTPS, TLS 1.2+, forward secrecy. Enabled by default. To allow HTTP: Info.plist NSAppTransportSecurity, NSExceptionDomains. Only for dev or legacy; never for production user data.

**Key points:**
- HTTPS required by default
- NSAllowsArbitraryLoads (disable all) - avoid
- NSExceptionDomains for specific
- Justification required for App Store

**Related to check:** HTTPS, security, Info.plist

</details>

---

### Decoding Error Handling

**Q:** How do you handle JSON decoding errors?

<details>
<summary>Reveal answer</summary>

**Short answer:** DecodingError provides context: keyPath, type, description. Use do-catch. Log for debugging. Consider optional properties for optional API fields. Use custom init(from:) for complex cases.

**Key points:**
- DecodingError.keyNotFound, .typeMismatch
- error.context.codingPath
- Optional for missing keys
- Custom decoder for flexibility

**Related to check:** Codable, DecodingError

</details>

---

### Pagination

**Q:** How do you implement pagination for API responses?

<details>
<summary>Reveal answer</summary>

**Short answer:** Load initial page; load more when user scrolls near end. Offset-based (page, limit) or cursor-based (nextCursor). Append to list. Prevent duplicate requests. Handle loading state.

**Key points:**
- Offset: ?page=2&limit=20
- Cursor: ?cursor=abc123
- Load more on scroll
- Deduplication, loading flag

**Related to check:** UITableView, prefetch, infinite scroll

</details>

---

### REST vs GraphQL

**Q:** What's the difference between REST and GraphQL?

<details>
<summary>Reveal answer</summary>

**Short answer:** REST: multiple endpoints, fixed response shape. GraphQL: single endpoint, client specifies fields. REST: over-fetching/under-fetching. GraphQL: precise request. GraphQL needs different client (Apollo, etc.).

**Key points:**
- REST: GET /users, GET /users/1
- GraphQL: POST with query
- REST: server determines shape
- GraphQL: client determines shape

**Related to check:** REST, API design, GraphQL

</details>

---

### Nested Codable Structures

**Q:** How do you decode nested JSON structures?

<details>
<summary>Reveal answer</summary>

**Short answer:** Nested types are decoded automatically if they conform to Codable. Define nested structs. Use optional for nullable nested. Use CodingKeys for nested key mapping. Custom init for complex nesting.

**Key points:**
- Nested structs conform to Codable
- Automatic decoding
- Optional for null
- Key paths in CodingKeys

**Related to check:** Codable, JSON, nested types

</details>

---

### Network Reachability

**Q:** How do you check network reachability?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use Network framework's NWPathMonitor. Check path.status (satisfied, unsatisfied). Monitor for changes. Don't block on reachability before request—attempt and handle failure. Use for UI hints (offline indicator).

**Key points:**
- NWPathMonitor
- path.status
- path.isExpensive (cellular)
- path.isConstrained (low data mode)

**Related to check:** Network framework, connectivity

</details>

---

### Codable Enums

**Q:** How do you decode enums with Codable?

<details>
<summary>Reveal answer</summary>

**Short answer:** Enums with raw value (String, Int) decode automatically. Use CodingKeys or custom init for non-raw. For unknown values: use optional or default case. For associated values: custom init.

**Key points:**
- enum Status: String, Codable
- Raw value = JSON value
- init(from decoder) for custom
- Handle unknown values

**Related to check:** Codable, enums, JSON

</details>

---

### Request/Response Interceptors

**Q:** How do you add logging or modify all requests (e.g., add auth)?

<details>
<summary>Reveal answer</summary>

**Short answer:** Wrap URLSession or use a custom protocol. Before request: add headers, log. After response: log, retry. Use a wrapper type that modifies URLRequest and handles URLResponse. Or use URLProtocol for low-level.

**Key points:**
- Wrapper around APIClient
- Modify request before send
- Handle response
- Add auth, logging, retry

**Related to check:** Middleware, authentication, logging

</details>

---

### WebSockets

**Q:** How do you implement WebSocket connections?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use URLSessionWebSocketTask. Create with URLSession.webSocketTask(with:). Connect, send, receive. Receive is async loop. Handle connection lifecycle: connect, disconnect, reconnect.

**Key points:**
- URLSessionWebSocketTask
- send(.string or .data)
- receive() async
- Ping/pong for keepalive

**Related to check:** URLSession, async/await, real-time

</details>

---

### Codable and Dates

**Q:** How do you handle date encoding/decoding?

<details>
<summary>Reveal answer</summary>

**Short answer:** Set dateEncodingStrategy and dateDecodingStrategy on JSONEncoder/Decoder. Options: iso8601, formatted(DateFormatter), custom. ISO8601 common for APIs. Use .iso8601 for standard format.

**Key points:**
- dateDecodingStrategy
- .iso8601
- .formatted(formatter)
- .custom { }

**Related to check:** Codable, Date, JSON

</details>

---

### Request Prioritization

**Q:** How do you prioritize network requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSessionTask has priority (0-1). Set task.priority. Use OperationQueue with priority for custom ordering. Cancel low-priority when high-priority needed. QoS: userInitiated for user waiting.

**Key points:**
- URLSessionTask.priority
- OperationQueue for ordering
- Cancel in-flight when needed
- QoS for queue

**Related to check:** URLSession, QoS, cancellation

</details>

---

### Response Validation

**Q:** How do you validate HTTP responses?

<details>
<summary>Reveal answer</summary>

**Short answer:** Check status code: 200-299 success. Validate Content-Type. Check response headers. Use guard for success range. Map to errors for 4xx, 5xx. Validate before decoding.

**Key points:**
- (response as? HTTPURLResponse)?.statusCode
- 200..<300 for success
- Content-Type: application/json
- Validate before decode

**Related to check:** HTTP, error handling, status codes

</details>

---

### Multipart Form Upload

**Q:** How do you upload multipart form data (e.g., image + fields)?

<details>
<summary>Reveal answer</summary>

**Short answer:** Build multipart body with boundary. Each part has headers (Content-Disposition, Content-Type) and body. Use uploadTask with Data or file. Set Content-Type: multipart/form-data; boundary=...

**Key points:**
- Boundary string
- --boundary\r\n
- Content-Disposition: form-data; name="field"
- End with --boundary--

**Related to check:** HTTP, upload, form data

</details>

---

### HTTP/2 and HTTP/3

**Q:** What are HTTP/2 and HTTP/3? How do they affect iOS?

<details>
<summary>Reveal answer</summary>

**Short answer:** HTTP/2: multiplexing, header compression. HTTP/3: QUIC, UDP. URLSession supports both. Faster.

**Key points:**
- Multiplexing
- QUIC
- URLSession
- Benefits

**Related to check:** Connection pooling, gRPC on iOS, Chunked transfer

</details>

---

### Certificate Pinning Implementation

**Q:** How do you implement certificate pinning?

<details>
<summary>Reveal answer</summary>

**Short answer:** Pin public key or certificate. URLSessionDelegate. Reject on mismatch. Handle rotation.

**Key points:**
- URLSessionDelegate
- didReceive challenge
- Pin type
- Rotation

**Related to check:** Proxy configuration, Request signing, Secrets management

</details>

---

### Request Deduplication

**Q:** How do you deduplicate in-flight requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Cache in-flight requests by key. Subsequent callers await same task. Share result.

**Key points:**
- Task cache
- Key by URL+params
- Await shared
- Cancel handling

**Related to check:** Idempotency, Response caching, Connection pooling

</details>

---

### Response Caching

**Q:** How does URLCache work? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLCache caches responses. Configure size. CachePolicy. Memory and disk. Use for GET.

**Key points:**
- URLCache
- CachePolicy
- Memory/disk
- Invalidation

**Related to check:** Request deduplication, Content negotiation, Download resume

</details>

---

### OAuth 2.0 Flow

**Q:** How do you implement OAuth 2.0 in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Authorization code flow. ASWebAuthenticationSession for browser. Exchange code for tokens. Refresh.

**Key points:**
- ASWebAuthenticationSession
- Callback URL
- Token exchange
- Refresh

**Related to check:** Certificate pinning, Secrets management, Request signing

</details>

---

### GraphQL Client

**Q:** How would you implement a GraphQL client?

<details>
<summary>Reveal answer</summary>

**Short answer:** Single endpoint. POST with query. Parse JSON response. Cache by query. Consider Apollo or similar.

**Key points:**
- Single endpoint
- Query string
- Variables
- Caching

**Related to check:** Response caching, API documentation, gRPC on iOS

</details>

---

### gRPC on iOS

**Q:** What is gRPC? When would you use it on iOS?

<details>
<summary>Reveal answer</summary>

**Short answer:** HTTP/2, Protocol Buffers. Efficient binary. Streaming. Use for performance-critical, streaming APIs.

**Key points:**
- Protocol Buffers
- Streaming
- HTTP/2
- When to use

**Related to check:** HTTP/2 and HTTP/3, GraphQL client, Connection pooling

</details>

---

### WebSocket Reconnection

**Q:** How do you handle WebSocket reconnection?

<details>
<summary>Reveal answer</summary>

**Short answer:** Exponential backoff. Detect disconnect. Reconnect with same state. Handle message ordering.

**Key points:**
- Backoff
- Heartbeat
- State
- Ordering

**Related to check:** Chunked transfer, API rate limiting, Connection pooling

</details>

---

### Request Signing

**Q:** How do you sign API requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** HMAC or similar. Sign method, path, body, timestamp. Add signature header. Verify on server.

**Key points:**
- HMAC
- Timestamp
- Replay protection
- Header

**Related to check:** Certificate pinning, OAuth 2.0 flow, Secrets management

</details>

---

### API Rate Limiting

**Q:** How do you handle API rate limiting client-side?

<details>
<summary>Reveal answer</summary>

**Short answer:** Respect Retry-After. Back off. Queue requests. Don't hammer. User feedback.

**Key points:**
- Retry-After
- 429 handling
- Backoff
- Queue

**Related to check:** Request deduplication, OAuth 2.0 flow, Circuit breaker

</details>

---

### Chunked Transfer

**Q:** What is chunked transfer encoding? When do you see it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Streaming response. No Content-Length. Chunks with size. Common for streaming APIs.

**Key points:**
- Transfer-Encoding
- Streaming
- No Content-Length
- Use case

**Related to check:** Download resume, WebSocket reconnection, HTTP/2 and HTTP/3

</details>

---

### Connection Pooling

**Q:** Does URLSession pool connections?

<details>
<summary>Reveal answer</summary>

**Short answer:** Yes. Reuses TCP connections. Keep-alive. Automatic. Configure with URLSessionConfiguration.

**Key points:**
- Connection reuse
- Keep-alive
- Configuration
- Automatic

**Related to check:** HTTP/2 and HTTP/3, Chunked transfer, Request deduplication

</details>

---

### Proxy Configuration

**Q:** How do you configure a proxy for URLSession?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLSessionConfiguration.connectionProxyDictionary. Or use system proxy. Corporate networks.

**Key points:**
- connectionProxyDictionary
- System proxy
- Auth
- Testing

**Related to check:** Certificate pinning, Request signing, API mocking strategy

</details>

---

### Download Resume

**Q:** How do you resume an interrupted download?

<details>
<summary>Reveal answer</summary>

**Short answer:** Store partial data. Use Range header. Resume from byte offset. URLSessionDownloadTask.

**Key points:**
- Range header
- ResumeData
- Byte offset
- Resumable

**Related to check:** Chunked transfer, Connection pooling, Response caching

</details>

---

### Request/Response Logging

**Q:** How do you log requests and responses for debugging?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLProtocol or URLSession delegate. Log URL, headers, body (redact secrets). Dev only.

**Key points:**
- URLProtocol
- Delegate
- Redaction
- Dev only

**Related to check:** Logging levels, Secrets management, Proxy configuration

</details>

---

### API Mocking Strategy

**Q:** How do you mock APIs for development?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLProtocol, mock server, or stub layer. Switch via config. Same interface as real.

**Key points:**
- URLProtocol
- Stub
- Config switch
- Consistency

**Related to check:** Contract testing, API documentation, Dependency injection

</details>

---

### Content Negotiation

**Q:** What is content negotiation? How does Accept header work?

<details>
<summary>Reveal answer</summary>

**Short answer:** Client sends Accept: application/json. Server responds with Content-Type. Negotiate format.

**Key points:**
- Accept
- Content-Type
- Quality values
- Multiple formats

**Related to check:** HTTP headers, API design, Response caching

</details>

---

### Idempotency

**Q:** What is idempotency? Why does it matter for APIs?

<details>
<summary>Reveal answer</summary>

**Short answer:** Same request, same result. Safe to retry. Use Idempotency-Key header for POST. Prevents duplicates.

**Key points:**
- Idempotency-Key
- Retry safety
- POST
- Design

**Related to check:** Retry strategies, Request deduplication, API design

</details>

---

### API Documentation

**Q:** How do you keep API docs in sync with the client?

<details>
<summary>Reveal answer</summary>

**Short answer:** OpenAPI/Swagger. Generate client or validate. Contract testing. Single source of truth.

**Key points:**
- OpenAPI
- Codegen
- Contract tests
- Sync

**Related to check:** API versioning, Contract testing, API mocking strategy

</details>

---

## Concurrency

### async/await

**Q:** Explain async/await in Swift. How does it work?

<details>
<summary>Reveal answer</summary>

**Short answer:** async/await is Swift's structured concurrency for asynchronous code. Mark functions with async; call with await. The compiler manages suspension and resumption. No callback pyramids; code reads like synchronous flow.

**Key points:**
- async function can suspend; caller awaits
- Suspension doesn't block the thread
- Must be called from async context (Task, async function)
- Errors propagate with throws

**Related to check:** Task, MainActor, actors, structured concurrency

</details>

---

### MainActor

**Q:** What is MainActor? When do you need it?

<details>
<summary>Reveal answer</summary>

**Short answer:** MainActor is the actor that runs on the main thread. UI must update on main. Mark types or functions with @MainActor to ensure they run on main. Use when updating UI from async code.

**Key points:**
- @MainActor on class, struct, or function
- MainActor.run { } to hop to main
- Task { @MainActor in } for main-isolated work
- UIViewController, UIView are implicitly main-actor

**Related to check:** Actors, async/await, UI thread

</details>

---

### Task

**Q:** What is Task? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Task creates a new asynchronous context. Use Task { } to call async code from sync. Task inherits actor context and priority. Use Task.detached for independent work. Tasks can be cancelled.

**Key points:**
- Task { await asyncWork() }
- Task.value for result; Task.isCancelled
- Task.detached for unstructured, no inheritance
- task modifier in SwiftUI

**Related to check:** async/await, cancellation, TaskGroup

</details>

---

### Grand Central Dispatch

**Q:** What is Grand Central Dispatch? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** GCD is Apple's concurrency API for dispatching work to queues. Queues can be serial or concurrent. Main queue runs on main thread. Use DispatchQueue.main for UI; background queues for heavy work.

**Key points:**
- DispatchQueue.main, DispatchQueue.global()
- async vs sync; avoid sync on main
- Serial vs concurrent queues
- DispatchGroup for waiting on multiple tasks

**Related to check:** DispatchQueue, DispatchGroup, OperationQueue

</details>

---

### OperationQueue

**Q:** What is OperationQueue? How does it differ from GCD?

<details>
<summary>Reveal answer</summary>

**Short answer:** OperationQueue is object-oriented concurrency. You add Operation (or BlockOperation) instances. Supports dependencies, cancellation, priority. Higher level than GCD; use when you need dependencies or cancellation.

**Key points:**
- OperationQueue manages Operation objects
- Dependencies: op2.addDependency(op1)
- Cancellation: operation.cancel()
- BlockOperation for simple blocks

**Related to check:** GCD, Operation, cancellation

</details>

---

### Actors

**Q:** What are actors in Swift? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Actors are reference types that isolate state. Only one task can access an actor's state at a time. Access is async (await). Prevents data races. Use for shared mutable state that needs thread safety.

**Key points:**
- actor Keyword { var state }
- Access from outside: await actor.method()
- MainActor is a special actor
- Replaces locks for shared state

**Related to check:** async/await, MainActor, Sendable, data races

</details>

---

### Sendable

**Q:** What is Sendable? Why does it matter for concurrency?

<details>
<summary>Reveal answer</summary>

**Short answer:** Sendable marks types that can be safely passed across concurrency domains (actors, tasks). Value types (struct, enum) are Sendable when their members are. Classes must be explicitly marked and be final with Sendable members.

**Key points:**
- protocol Sendable: no requirements
- Value types: Sendable if members are
- Classes: must be final, Sendable members
- Compiler checks when passing across actor boundaries

**Related to check:** Actors, async/await, data races

</details>

---

### Thread Safety

**Q:** How do you achieve thread safety in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Thread safety: ensure shared mutable state isn't accessed concurrently from multiple threads. Options: actors, locks (NSLock), serial queues, atomic operations. Actors are preferred for new code.

**Key points:**
- Actors: isolate state, automatic serialization
- Serial DispatchQueue: all access on one queue
- NSLock, os_unfair_lock for critical sections
- Immutable data is inherently thread-safe

**Related to check:** Actors, GCD, locks, data races

</details>

---

### Retain Cycles in Async Code

**Q:** How can you avoid retain cycles in async code?

<details>
<summary>Reveal answer</summary>

**Short answer:** In async closures and Tasks, capture self weakly to avoid retain cycles. Use [weak self] in closures; Task captures self by default. Check for nil after await when using weak self.

**Key points:**
- Task { await self.method() } captures self strongly
- Use [weak self] in closures; Task { [weak self] in ... }
- After await, self might be deallocated—check guard let self
- @Sendable closures can't capture self strongly in some contexts

**Related to check:** ARC, closures, Task

</details>

---

### TaskGroup

**Q:** What is TaskGroup? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** TaskGroup runs multiple child tasks concurrently and collects results. Use with withTaskGroup or withThrowingTaskGroup. TaskGroup is structured—parent waits for children. Use for parallel work (e.g., fetch multiple URLs).

**Key points:**
- withTaskGroup(of:body:)
- group.addTask { }
- Results collected from for await
- Cancellation propagates to children

**Related to check:** Task, async/await, structured concurrency

</details>

---

### async let

**Q:** What is async let? How does it differ from TaskGroup?

<details>
<summary>Reveal answer</summary>

**Short answer:** async let starts a child task and defers awaiting. Use when you have a fixed number of parallel tasks. async let x = ... starts immediately; await x when you need the result. Simpler than TaskGroup for fixed parallelism.

**Key points:**
- async let x = fetchData()
- await x when needed
- All async let tasks run concurrently
- Must await before scope ends

**Related to check:** TaskGroup, async/await, structured concurrency

</details>

---

### Continuations

**Q:** What are continuations? How do you bridge callback-based APIs to async/await?

<details>
<summary>Reveal answer</summary>

**Short answer:** Continuations wrap callback-based APIs for async/await. withCheckedContinuation or withUnsafeContinuation suspends until you call resume. Must call resume exactly once. Use to adapt legacy async APIs.

**Key points:**
- withCheckedContinuation { continuation in }
- continuation.resume(returning:)
- Must resume exactly once
- CheckedContinuation detects multiple resume

**Related to check:** async/await, callbacks, bridging

</details>

---

### Race Conditions and Data Races

**Q:** What's the difference between a race condition and a data race?

<details>
<summary>Reveal answer</summary>

**Short answer:** A data race is concurrent access to the same memory where at least one access is a write. A race condition is a bug where outcome depends on timing. Data races are undefined behavior; race conditions are logic bugs.

**Key points:**
- Data race: memory safety violation, multiple threads, one write
- Race condition: timing-dependent bug (e.g., check-then-act)
- Swift's concurrency prevents data races with actors
- Race conditions need careful design

**Related to check:** Actors, thread safety, data races

</details>

---

### Structured Concurrency

**Q:** What is structured concurrency?

<details>
<summary>Reveal answer</summary>

**Short answer:** Structured concurrency means child tasks are tied to a parent. When the parent is cancelled or completes, children are cancelled or awaited. No orphan tasks. async/await, TaskGroup, and async let are structured.

**Key points:**
- Parent-child relationship
- Cancellation propagates down
- Parent waits for children
- Task.detached breaks structure

**Related to check:** Task, TaskGroup, cancellation

</details>

---

### Task Cancellation

**Q:** How does task cancellation work? How do you handle it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Call task.cancel() to request cancellation. Tasks check Task.isCancelled or use CheckedContinuation. Cancellation is cooperative—your code must check and stop. Throws CancellationError when awaited if cancelled.

**Key points:**
- task.cancel() requests cancellation
- Check Task.isCancelled in loops
- CancellationError when awaiting cancelled task
- Child tasks are cancelled when parent is

**Related to check:** Task, TaskGroup, structured concurrency

</details>

---

### Serial vs Concurrent Queue

**Q:** What's the difference between serial and concurrent queues in GCD?

<details>
<summary>Reveal answer</summary>

**Short answer:** Serial queues execute one task at a time; concurrent queues can run multiple tasks in parallel. Main queue is serial. Use serial for thread safety; concurrent for parallel work when tasks are independent.

**Key points:**
- Serial: one at a time, FIFO order
- Concurrent: multiple tasks, still FIFO start
- DispatchQueue.main is serial
- DispatchQueue.global() is concurrent

**Related to check:** GCD, thread safety, DispatchQueue

</details>

---

### Dispatch Barrier

**Q:** What is a dispatch barrier? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** A barrier block on a concurrent queue runs exclusively—no other blocks run while it executes. Use for writes when you have concurrent reads. Reads can run in parallel; writes are exclusive.

**Key points:**
- dispatch_barrier_async or DispatchWorkItem(flags: .barrier)
- Only on custom concurrent queue (not global)
- Barrier waits for prior blocks, blocks subsequent
- Reader-writer pattern

**Related to check:** GCD, concurrent queue, thread safety

</details>

---

### DispatchSemaphore

**Q:** What is DispatchSemaphore? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** DispatchSemaphore limits concurrent access. wait() decrements (blocks if zero); signal() increments. Use to limit concurrent operations (e.g., max 3 network requests) or for signaling between threads.

**Key points:**
- DispatchSemaphore(value: n)
- wait() blocks if count is 0
- signal() increments count
- Can cause deadlock if misused

**Related to check:** GCD, concurrency limits, synchronization

</details>

---

### Combine Publishers and async/await

**Q:** How do you use Combine publishers with async/await?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .values (AsyncPublisher) or .asyncSequence() to consume publishers with for await. Or wrap in withCheckedContinuation. Prefer async/await for new code; use Combine when integrating with existing publishers.

**Key points:**
- publisher.values is AsyncSequence
- for await value in publisher.values { }
- First value or completion
- Cancellation via Task

**Related to check:** Combine, async/await, AsyncSequence

</details>

---

### AsyncSequence

**Q:** What is AsyncSequence? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** AsyncSequence is the async version of Sequence. Use for await to iterate. AsyncStream creates one. Use for streaming data—network, notifications, timers. Conforms to AsyncSequence protocol.

**Key points:**
- for await item in asyncSequence { }
- AsyncStream, AsyncThrowingStream
- map, filter, etc. on AsyncSequence
- Cancellation stops iteration

**Related to check:** async/await, AsyncStream, Combine

</details>

---

### Global Actors

**Q:** What are global actors? How do you create a custom one?

<details>
<summary>Reveal answer</summary>

**Short answer:** Global actors are singletons that provide actor isolation. MainActor is one. You can define custom global actors with @globalActor. Use for app-wide isolation (e.g., database actor, network actor).

**Key points:**
- @globalActor struct MyActor { actor }
- Mark types/functions with @MyActor
- Shared singleton instance
- await when crossing boundary

**Related to check:** MainActor, actors, isolation

</details>

---

### nonisolated

**Q:** What does nonisolated mean? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** nonisolated marks a method or property as not isolated to the actor. It can be called without await from outside. Use for methods that don't touch actor state, or for protocol requirements that can't be async.

**Key points:**
- nonisolated func or var
- Can't access actor state (compiler error)
- Used for Sendable conformance, protocol requirements
- Sync entry point from outside

**Related to check:** Actors, isolation, Sendable

</details>

---

### Deadlock

**Q:** What causes deadlock? How do you avoid it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Deadlock occurs when two or more tasks wait for each other. Common: sync on main from main; A waits for B, B waits for A. Avoid by not blocking, using async, and consistent lock ordering.

**Key points:**
- Never sync on the same queue you're on
- Avoid sync from main
- Lock ordering: always acquire in same order
- Prefer async over sync

**Related to check:** GCD, sync vs async, locks

</details>

---

### Quality of Service

**Q:** What is QoS in GCD? What are the priority levels?

<details>
<summary>Reveal answer</summary>

**Short answer:** QoS (Quality of Service) hints the system about task priority. Higher QoS gets more resources. Levels: userInteractive, userInitiated, default, utility, background. Use appropriate level for work type.

**Key points:**
- userInteractive: UI, animations
- userInitiated: user waiting (e.g., button tap)
- utility: progress, not urgent
- background: maintenance, prefetch

**Related to check:** GCD, DispatchQueue, performance

</details>

---

### Actor Reentrancy

**Q:** What is actor reentrancy? Why does it matter?

<details>
<summary>Reveal answer</summary>

**Short answer:** When an actor method suspends at await, the actor can run other work before resuming. State may have changed. Don't assume state is unchanged after await. Reentrancy allows progress but requires careful handling.

**Key points:**
- Suspension points allow interleaving
- State can change between await and resume
- Revalidate assumptions after await
- Copy state before await if needed

**Related to check:** Actors, await, suspension

</details>

---

### RunLoop and Main Thread

**Q:** What is the RunLoop? How does it relate to the main thread?

<details>
<summary>Reveal answer</summary>

**Short answer:** RunLoop processes input sources (events, timers) on a thread. Main thread has a RunLoop that processes UI events, timers, and performSelector. Blocking the main RunLoop blocks UI.

**Key points:**
- Each thread can have a RunLoop
- Main RunLoop: UI, CADisplayLink, timers
- run() processes events
- Blocking main = frozen UI

**Related to check:** Main thread, GCD, UI responsiveness

</details>

---

### Thread vs Queue

**Q:** What's the difference between a thread and a queue in GCD?

<details>
<summary>Reveal answer</summary>

**Short answer:** Threads are execution contexts; queues are work schedules. GCD manages a pool of threads. You submit work to queues; GCD assigns threads. You don't manage threads directly—you use queues.

**Key points:**
- Queue: abstraction for scheduling
- Thread: OS execution unit
- One queue can use multiple threads (concurrent)
- Serial queue uses one thread

**Related to check:** GCD, threads, MainActor

</details>

---

### asyncAfter

**Q:** How do you delay execution in Swift? asyncAfter vs Task.sleep?

<details>
<summary>Reveal answer</summary>

**Short answer:** DispatchQueue.asyncAfter schedules work after a delay. Task.sleep suspends the current task. Use asyncAfter for fire-and-forget delay; Task.sleep in async code when you need to wait.

**Key points:**
- asyncAfter(deadline:execute:)
- Doesn't block; schedules for later
- Task.sleep(nanoseconds:) in async
- try await Task.sleep(for: .seconds(1)) (Swift 5.7+) or Task.sleep(nanoseconds:)

**Related to check:** GCD, Task, Timer

</details>

---

### Thread-Safe Singleton

**Q:** How do you implement a thread-safe singleton?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use static let for lazy, thread-safe initialization (Swift guarantee). Or use dispatch_once pattern (Obj-C). For actors, use a global actor. Avoid double-checked locking.

**Key points:**
- static let shared = MyClass() — Swift guarantees thread-safe init
- Lazy, one-time initialization
- No explicit locking needed
- Actor-based: @globalActor

**Related to check:** Lazy initialization, actors, thread safety

</details>

---

### async throws

**Q:** How do async and throws work together?

<details>
<summary>Reveal answer</summary>

**Short answer:** Functions can be async throws—they suspend and can throw. Call with try await. Errors propagate up. Use for async operations that can fail (network, file I/O).

**Key points:**
- func load() async throws -> Data
- try await load()
- do-catch for errors
- async throws propagates both

**Related to check:** async/await, error handling, throws

</details>

---

### Task Local Values

**Q:** What are task-local values? When do you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Values bound to a task. Propagate to child tasks. Use for request ID, logger context.

**Key points:**
- @TaskLocal
- withValue
- Propagation
- Context

**Related to check:** Task, Async context, Logging

</details>

---

### Task.yield

**Q:** What does Task.yield do? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Yields to other tasks. Cooperative multitasking. Use in long loops to prevent starvation.

**Key points:**
- Task.yield
- Cooperative
- Long loops
- Fairness

**Related to check:** Task, Cooperative scheduling, Executor

</details>

---

### Unstructured Concurrency

**Q:** What is unstructured concurrency? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Task.init or Task.detached. Not child of current task. Use when you need fire-and-forget.

**Key points:**
- Task.init
- Task.detached
- No parent
- When to use

**Related to check:** TaskGroup, async let, Task.detached

</details>

---

### AsyncStream

**Q:** How do you use AsyncStream? When is it useful?

<details>
<summary>Reveal answer</summary>

**Short answer:** Backpressure-friendly async sequence. Yield values. Use for async callbacks, streams.

**Key points:**
- AsyncStream
- yield
- Continuation
- Backpressure

**Related to check:** AsyncSequence, AsyncThrowingStream, TaskGroup

</details>

---

### MainActor.assumeIsolated

**Q:** What is MainActor.assumeIsolated? When is it safe?

<details>
<summary>Reveal answer</summary>

**Short answer:** Asserts already on main actor. Avoids await. Use in MainActor context when certain.

**Key points:**
- assumeIsolated
- Assert
- When safe
- Performance

**Related to check:** @MainActor, Main thread, Actors

</details>

---

### @Sendable Closures

**Q:** When must closures be Sendable?

<details>
<summary>Reveal answer</summary>

**Short answer:** Closures passed to async/isolated contexts. Captured values must be Sendable. Compiler checks.

**Key points:**
- @Sendable
- Capture
- Cross-actor
- Compiler

**Related to check:** Sendable, Actors, Strict concurrency

</details>

---

### Cooperative Cancellation

**Q:** How do you implement cooperative cancellation?

<details>
<summary>Reveal answer</summary>

**Short answer:** Check Task.isCancelled. Throw CancellationError. Clean up resources. Propagate.

**Key points:**
- isCancelled
- CancellationError
- Cleanup
- Propagation

**Related to check:** Task.cancel, CancellationError, TaskGroup

</details>

---

### Actor Isolation Rules

**Q:** What are the actor isolation rules?

<details>
<summary>Reveal answer</summary>

**Short answer:** Actor-isolated state only from same actor. Async to call from outside. Sendable for passing.

**Key points:**
- Isolation
- async access
- Sendable
- Rules

**Related to check:** Actors, Sendable, @MainActor

</details>

---

### Global Actor Isolation

**Q:** How do you create a custom global actor?

<details>
<summary>Reveal answer</summary>

**Short answer:** actor MyActor {}. Mark with @MyActor. Shared singleton. Like MainActor.

**Key points:**
- Custom actor
- @MyActor
- Singleton
- Use case

**Related to check:** @MainActor, Actors, Isolation

</details>

---

### AsyncIteratorProtocol

**Q:** What is AsyncIteratorProtocol? How does it relate to AsyncSequence?

<details>
<summary>Reveal answer</summary>

**Short answer:** AsyncSequence has makeAsyncIterator(). Iterator has next() async. For-in uses it.

**Key points:**
- makeAsyncIterator
- next()
- AsyncSequence
- Custom sequences

**Related to check:** AsyncSequence, AsyncStream, for await

</details>

---

### TaskGroup and ThrowingTaskGroup

**Q:** When do you use ThrowingTaskGroup?

<details>
<summary>Reveal answer</summary>

**Short answer:** When child tasks can throw. Errors propagate. Use for parallel work that may fail.

**Key points:**
- ThrowingTaskGroup
- Error propagation
- try await
- When to use

**Related to check:** TaskGroup, async let, Error propagation

</details>

---

### @preconcurrency

**Q:** What is @preconcurrency? When do you need it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Suppresses Sendable warnings for legacy code. Use when migrating. Mark import or declaration.

**Key points:**
- @preconcurrency
- Legacy
- Migration
- Suppress

**Related to check:** Sendable, Strict concurrency, Migration

</details>

---

### Task Priority

**Q:** How does task priority work? Can you change it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Task inherits priority. Use Task(priority:). high, medium, low, utility, background.

**Key points:**
- Priority
- Inheritance
- Task(priority:)
- QoS

**Related to check:** Task, QoS, DispatchQueue priority

</details>

---

### Reentrancy and Actors

**Q:** What is actor reentrancy? Why does it matter?

<details>
<summary>Reveal answer</summary>

**Short answer:** Actor can suspend and resume. Another call can run. State may change. Design for it.

**Key points:**
- Reentrancy
- Suspension points
- State
- Design

**Related to check:** Actors, Suspension points, Task.yield

</details>

---

### Sync to Async Bridge

**Q:** How do you call async code from sync context?

<details>
<summary>Reveal answer</summary>

**Short answer:** Task { }. RunBlocking (avoid). Continuations. Detached task. No ideal way.

**Key points:**
- Task
- Continuations
- RunBlocking
- Trade-offs

**Related to check:** Task, Continuations, CheckedContinuation

</details>

---

### Async to Sync Bridge

**Q:** How do you call sync code from async context?

<details>
<summary>Reveal answer</summary>

**Short answer:** Usually fine. Use MainActor.run for main thread. Avoid blocking.

**Key points:**
- MainActor.run
- Blocking
- When needed
- Alternatives

**Related to check:** MainActor, Sync to async bridge, Executor

</details>

---

### DispatchWorkItem

**Q:** What is DispatchWorkItem? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Encapsulates work. Can cancel. Can notify. Use for cancellable delayed work.

**Key points:**
- DispatchWorkItem
- cancel
- notify
- Delayed

**Related to check:** DispatchQueue, Task cancellation, GCD

</details>

---

### DispatchGroup

**Q:** How do you use DispatchGroup? When?

<details>
<summary>Reveal answer</summary>

**Short answer:** Group async work. enter/leave. notify for completion. Use when waiting for multiple tasks.

**Key points:**
- enter
- leave
- notify
- Multiple tasks

**Related to check:** DispatchQueue, TaskGroup, async let

</details>

---

### NSLock and Mutex

**Q:** When would you use NSLock instead of an actor?

<details>
<summary>Reveal answer</summary>

**Short answer:** Legacy code. C interop. Very low-level. Prefer actors for new code.

**Key points:**
- NSLock
- lock/unlock
- When to use
- Actors preferred

**Related to check:** Actors, os_unfair_lock, Synchronization

</details>

---

## Memory & Performance

### Retain Cycles

**Q:** What causes retain cycles? How do you find and fix them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Retain cycles occur when objects reference each other strongly, preventing deallocation. Common: delegate (strong), closure capturing self strongly. Fix: weak/unowned references, [weak self] in closures.

**Key points:**
- A → B → A (cycle)
- delegate: use weak
- Closures: [weak self] or [unowned self]
- Instruments: Leaks, Allocations

**Related to check:** ARC, weak, unowned, closures

</details>

---

### ARC

**Q:** How does ARC work? What are strong, weak, and unowned references?

<details>
<summary>Reveal answer</summary>

**Short answer:** ARC (Automatic Reference Counting) manages memory by counting references. Strong increments count; weak and unowned don't. When count reaches zero, object is deallocated. Weak becomes nil when object deallocates; unowned assumes it never does.

**Key points:**
- Strong: default, increments retain count
- Weak: doesn't increment, becomes nil
- Unowned: doesn't increment, crashes if accessed when deallocated
- Compiler inserts retain/release

**Related to check:** Retain cycles, weak, unowned

</details>

---

### Instruments

**Q:** What Instruments would you use to debug memory and performance issues?

<details>
<summary>Reveal answer</summary>

**Short answer:** Leaks: find retain cycles. Allocations: track allocations over time. Time Profiler: CPU usage. Core Animation: frame rate, GPU. Network: network traffic. Use for memory leaks, performance, battery.

**Key points:**
- Leaks: cycle detection
- Allocations: object lifecycle
- Time Profiler: where CPU time goes
- Core Animation: FPS, offscreen rendering

**Related to check:** Memory, performance, debugging

</details>

---

### Image Loading and Caching

**Q:** How do you efficiently load and cache images?

<details>
<summary>Reveal answer</summary>

**Short answer:** Load async; cache in memory (NSCache) and optionally disk. Decode off main thread. Downsample for display size. Use SDWebImage, Kingfisher, or custom. Avoid loading full-res for thumbnails.

**Key points:**
- Async loading
- NSCache for memory (auto-evicts)
- Downsampling: ImageIO, UIGraphicsImageRenderer
- Cancel in-flight when cell reused

**Related to check:** NSCache, GCD, UITableView

</details>

---

### Scroll Performance

**Q:** How do you optimize scrolling performance in UITableView/UICollectionView?

<details>
<summary>Reveal answer</summary>

**Short answer:** Cell reuse, lightweight cellForRow, avoid layout in scrollViewDidScroll, use opaque layers, avoid offscreen rendering. Prefetch data. Keep cell configuration fast. Use Instruments to find bottlenecks.

**Key points:**
- Reuse cells (dequeue)
- prepareForReuse to reset
- Avoid complex layout in scroll
- Opaque views, no cornerRadius + shadow
- Prefetch for async loading

**Related to check:** Cell reuse, Instruments, layers

</details>

---

### Lazy Loading

**Q:** What is lazy loading? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Lazy loading defers initialization until first access. Reduces startup time and memory. Use for: expensive setup, optional resources, properties that might not be needed. lazy var in Swift.

**Key points:**
- lazy var: initialized on first access
- Thread-safe in Swift (for let)
- Use when value might not be needed
- Can reduce memory footprint

**Related to check:** Performance, initialization, memory

</details>

---

### Autoreleasepool

**Q:** What is autoreleasepool? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** autoreleasepool drains autoreleased objects at pool boundary. Use in loops creating many autoreleased objects to prevent memory spike. Swift's autoreleasepool { } creates a scope.

**Key points:**
- Objects autoreleased when pool drains
- Loop with many temp objects: wrap in pool
- Reduces peak memory
- Main run loop has implicit pool

**Related to check:** ARC, memory, performance

</details>

---

### NSCache

**Q:** What is NSCache? How does it differ from Dictionary?

<details>
<summary>Reveal answer</summary>

**Short answer:** NSCache is a mutable cache that evicts objects under memory pressure. Unlike Dictionary, it doesn't copy keys, can limit count/cost, and automatically removes objects. Use for caches (images, computed data).

**Key points:**
- Evicts under memory pressure
- countLimit, totalCostLimit
- Thread-safe
- Doesn't copy keys (uses AnyObject)

**Related to check:** Caching, memory pressure, eviction

</details>

---

### Main Thread Best Practices

**Q:** Why should you avoid blocking the main thread? What are the consequences?

<details>
<summary>Reveal answer</summary>

**Short answer:** Main thread runs UI and RunLoop. Blocking it freezes the UI, causes ANRs, poor UX. Keep main thread for UI updates only. Offload: network, parsing, file I/O, heavy computation to background.

**Key points:**
- UI updates on main
- 60 FPS = ~16ms per frame
- Blocking = dropped frames, freeze
- Use GCD, async/await for background

**Related to check:** GCD, async/await, MainActor

</details>

---

### Offscreen Rendering

**Q:** What causes offscreen rendering? How do you avoid it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Offscreen rendering occurs when the GPU renders to an extra buffer (e.g., for masks, shadows, corner radius + layer). It's expensive. Avoid: cornerRadius + masksToBounds, shadowPath, group opacity, blend modes.

**Key points:**
- cornerRadius + masksToBounds can trigger
- shadowPath can help shadow performance
- Rasterization: layer.shouldRasterize
- Use Core Animation instrument

**Related to check:** CALayer, Core Animation, GPU

</details>

---

### Debug Memory Graph

**Q:** How do you use the Debug Memory Graph to find retain cycles?

<details>
<summary>Reveal answer</summary>

**Short answer:** Debug Memory Graph shows object graph at a point in time. Run app, trigger state, click memory graph button. Inspect objects, see references. Look for unexpected strong references (cycles).

**Key points:**
- Xcode: Debug → Debug Workflow → View Memory Graph
- Shows live objects and references
- Filter by type
- Find who retains what

**Related to check:** Retain cycles, Instruments, ARC

</details>

---

### App Launch Optimization

**Q:** How do you optimize app launch time?

<details>
<summary>Reveal answer</summary>

**Short answer:** Reduce work at launch: lazy load, defer non-critical init, avoid sync network, minimize dynamic libraries. Use MetricKit, Instruments (App Launch). Cold vs warm launch. System kills slow launchers.

**Key points:**
- Pre-main: reduce dylibs, +load
- Main: defer heavy init
- First frame: minimize first layout
- Lazy load features

**Related to check:** Lazy loading, MetricKit

</details>

---

### Battery Optimization

**Q:** How do you optimize for battery life?

<details>
<summary>Reveal answer</summary>

**Short answer:** Reduce CPU, network, location, and GPU usage. Batch network requests, use efficient algorithms, avoid timers when possible. Background tasks: minimize. Use Energy Log in Instruments.

**Key points:**
- CPU: efficient code, avoid busy-wait
- Network: batch, reduce frequency
- Location: accuracy, stop when not needed
- Screen: reduce brightness, animations

**Related to check:** Instruments, networking, location

</details>

---

### Copy-on-Write

**Q:** What is copy-on-write? How does it apply to Swift collections?

<details>
<summary>Reveal answer</summary>

**Short answer:** Copy-on-write (COW) defers copying until mutation. Multiple variables can share storage until one mutates. Swift's Array, Dictionary, Set use COW. Reduces unnecessary copies.

**Key points:**
- Copy only on write (mutation)
- Shared storage until then
- Value semantics with performance
- isKnownUniquelyReferenced for custom COW

**Related to check:** Value types, performance, collections

</details>

---

### Time Profiler

**Q:** How do you use the Time Profiler to find performance bottlenecks?

<details>
<summary>Reveal answer</summary>

**Short answer:** Time Profiler samples CPU usage. Record app, perform action, stop. View call tree—see where time is spent. Focus on your code; hide system. Find hot spots (methods taking most time).

**Key points:**
- Samples call stack
- Call tree, inverted
- Hide system libraries to focus on app
- Bottom-up vs top-down

**Related to check:** Instruments, performance, CPU

</details>

---

### JSON Parsing Performance

**Q:** How do you optimize JSON parsing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use Codable for type-safe parsing. Parse on background thread. For large JSON: use streaming (JSONDecoder with InputStream) or chunked. Avoid parsing entire response when you need a subset.

**Key points:**
- Codable is efficient
- Parse off main thread
- Streaming for large payloads
- Lazy decoding if supported

**Related to check:** Codable, async, networking

</details>

---

### View Hierarchy Performance

**Q:** How does view hierarchy depth affect performance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Deep hierarchies increase layout cost, hit testing, and memory. Flatten with stack views, reduce nesting. Each view has overhead. Use Debug View Hierarchy to inspect.

**Key points:**
- Layout traverses tree
- Hit testing traverses tree
- More views = more work
- Flatten when possible

**Related to check:** Auto Layout, UIStackView, layout

</details>

---

### Background Fetch and Processing

**Q:** How do you perform work in the background without draining battery?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use BGTaskScheduler for background fetch, processing. System decides when to run. Complete work quickly. Use URLSession background configuration for downloads. Avoid heavy work in background.

**Key points:**
- BGAppRefreshTask, BGProcessingTask
- System controls timing
- Limited time
- Efficient, batched work

**Related to check:** Background modes, battery, BGTask

</details>

---

### When to Use Weak References

**Q:** When should you use weak references? Give examples.

<details>
<summary>Reveal answer</summary>

**Short answer:** Use weak when the reference can outlive the object, or to break retain cycles. Examples: delegate, closure capturing self, parent-child where child holds parent. Weak becomes nil when object deallocates.

**Key points:**
- Delegate pattern
- Closures with self
- Parent in child (when child owns parent reference)
- Must be optional (var) for weak

**Related to check:** ARC, retain cycles, delegates

</details>

---

### Heap vs Stack

**Q:** What's the difference between heap and stack allocation?

<details>
<summary>Reveal answer</summary>

**Short answer:** Stack: fast, LIFO, limited size, for local variables and value types. Heap: dynamic, for reference types (classes), larger, slower. Structs often on stack; classes on heap. Stack is faster.

**Key points:**
- Stack: automatic, fast, scope-bound
- Heap: manual (ARC), dynamic lifetime
- Value types: often stack
- Classes: heap

**Related to check:** Value types, reference types, ARC

</details>

---

### Animation Performance

**Q:** How do you ensure smooth animations (60 FPS)?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use GPU-friendly properties: transform, opacity. Avoid layout during animation. Use CADisplayLink for custom. Keep work off main thread. Profile with Core Animation instrument.

**Key points:**
- Animate: transform, opacity (GPU)
- Avoid: frame, bounds during animation
- 60 FPS = 16ms per frame
- Offscreen rendering hurts

**Related to check:** Core Animation, GPU, transform

</details>

---

### Auto Layout Performance

**Q:** How can Auto Layout affect performance? How do you optimize it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Constraint solving is O(n) per layout pass. Many constraints, complex hierarchies = slower. Optimize: reduce constraints, use stack views, avoid unnecessary layout, set priority correctly.

**Key points:**
- Constraint solver runs each layout
- Fewer constraints = faster
- Stack views reduce constraints
- setNeedsLayout vs layoutIfNeeded

**Related to check:** Auto Layout, UIStackView, layout

</details>

---

### Handling Memory Warnings

**Q:** What should you do when the app receives a memory warning?

<details>
<summary>Reveal answer</summary>

**Short answer:** Override didReceiveMemoryWarning. Release caches, non-essential data, images. Don't release visible UI. Use NSCache (auto-evicts). System may kill app if memory isn't freed.

**Key points:**
- didReceiveMemoryWarning
- Release: caches, temp data, images
- Keep: visible UI, user data
- NSCache helps

**Related to check:** NSCache, caching, lifecycle

</details>

---

### Reducing Object Allocations

**Q:** How do you reduce object allocations in performance-critical code?

<details>
<summary>Reveal answer</summary>

**Short answer:** Reuse objects, use value types, avoid temporary allocations in loops. Object pooling for expensive objects. Use structs for small data. Profile with Allocations instrument.

**Key points:**
- Reuse (e.g., cell reuse)
- Value types (no heap)
- Object pool for expensive
- Avoid alloc in hot loops

**Related to check:** Cell reuse, value types, pooling

</details>

---

### Core Data Performance

**Q:** How do you optimize Core Data performance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use batch size for fetch, faulting, batch inserts. Index frequently queried attributes. Use background context for heavy work. Avoid fetching entire graph. Use NSPredicate efficiently.

**Key points:**
- fetchBatchSize
- Batch insert (NSBatchInsertRequest)
- Indexes on queried attributes
- Background context for saves

**Related to check:** Core Data, persistence, concurrency

</details>

---

### Compiler Optimizations

**Q:** What compiler optimizations affect iOS app performance?

<details>
<summary>Reveal answer</summary>

**Short answer:** Release build uses -O (optimize). Inlining, dead code elimination, loop unrolling. Whole module optimization. Use release for profiling. Debug build is slower.

**Key points:**
- -O optimization level
- Inlining
- Whole module optimization
- Release for accurate profiling

**Related to check:** Build settings, profiling

</details>

---

### MetricKit

**Q:** What is MetricKit? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** MetricKit collects performance metrics from users. Launch time, hang rate, memory, battery. Implement MXMetricManagerSubscriber. Receive reports daily. Use for real-world performance monitoring.

**Key points:**
- MXMetricManager.shared.add(self)
- didReceive metrics callback
- Launch, hang, memory, battery
- Per-device, aggregated

**Related to check:** Performance, monitoring, diagnostics

</details>

---

### OOM (Out of Memory)

**Q:** What causes OOM crashes? How do you prevent them?

<details>
<summary>Reveal answer</summary>

**Short answer:** OOM occurs when the app exceeds memory limit (~1.5GB on newer devices). Causes: memory leaks, large allocations, caching too much. Prevent: fix leaks, limit cache size, release when possible.

**Key points:**
- Jetsam limit
- Leaks increase usage
- Large images, caches
- Memory warnings before OOM

**Related to check:** Retain cycles, caching, memory warnings

</details>

---

### Async Image Decoding

**Q:** Why decode images off the main thread? How do you do it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Image decoding is CPU-intensive. PNG/JPEG decode can take 10-100ms. Doing it on main thread blocks UI. Decode on background, then assign to image view on main. Use ImageIO for downsampling.

**Key points:**
- Decoding blocks
- Do on background queue
- Assign on main
- Downsample for display size

**Related to check:** GCD, image loading, performance

</details>

---

### String and Collection Performance

**Q:** What are performance considerations for Strings and collections in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Strings are value types with copy-on-write. Large string operations can be expensive. Use Array when you need indexed access; Set for uniqueness; Dictionary for lookup. Avoid repeated concatenation—use join or Array.

**Key points:**
- String concatenation: use join, avoid + in loop
- Array: O(1) indexed, amortized append
- Set: O(1) contains, Hashable
- Dictionary: O(1) lookup

**Related to check:** Collections, copy-on-write, algorithms

</details>

---

### Memory Graph Debugger

**Q:** How do you use the Memory Graph Debugger?

<details>
<summary>Reveal answer</summary>

**Short answer:** Run app, capture graph. See object relationships. Find cycles. Xcode debug bar.

**Key points:**
- Capture
- Graph view
- Cycles
- Retain

**Related to check:** Leaks instrument, Capture lists, Allocations vs Leaks

</details>

---

### Instruments Allocations

**Q:** How do you use the Allocations instrument?

<details>
<summary>Reveal answer</summary>

**Short answer:** Track allocations. Mark generations. Find leaks. See growth.

**Key points:**
- Allocations
- Mark
- Generations
- Growth

**Related to check:** Allocations vs Leaks, VM Tracker, Memory graph debugger

</details>

---

### Leaks Instrument

**Q:** How does the Leaks instrument work?

<details>
<summary>Reveal answer</summary>

**Short answer:** Detects classic leaks. Run, reproduce. Check stack. Fix retain cycles.

**Key points:**
- Leaks
- Stack trace
- Cycles
- Fix

**Related to check:** Memory graph debugger, Allocations vs Leaks, Capture lists

</details>

---

### VM Tracker

**Q:** What does the VM Tracker show?

<details>
<summary>Reveal answer</summary>

**Short answer:** Virtual memory. Dirty, resident. Track growth. Find memory hogs.

**Key points:**
- Dirty
- Resident
- Growth
- Analysis

**Related to check:** Allocations vs Leaks, Memory graph debugger, Image downsampling

</details>

---

### Allocations vs Leaks

**Q:** What's the difference between Allocations and Leaks?

<details>
<summary>Reveal answer</summary>

**Short answer:** Allocations: everything. Leaks: only leaked. Use both. Allocations for growth.

**Key points:**
- Allocations
- Leaks
- When each
- Combined

**Related to check:** Leaks instrument, Memory graph debugger, Capture lists

</details>

---

### Symbolication

**Q:** How do you symbolicate a crash log?

<details>
<summary>Reveal answer</summary>

**Short answer:** dSYMs, Xcode Organizer. Or symbolicatecrash. Match binary.

**Key points:**
- dSYM
- Organizer
- symbolicatecrash
- Match

**Related to check:** Crash reporting, Leaks instrument, Memory graph debugger

</details>

---

### Address Sanitizer

**Q:** What does Address Sanitizer detect?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use-after-free, buffer overflow. Edit Scheme, enable. Slower.

**Key points:**
- ASan
- Use-after-free
- Overflow
- When to use

**Related to check:** UBSan, Thread Sanitizer, Leaks instrument

</details>

---

### Thread Sanitizer

**Q:** What does Thread Sanitizer detect?

<details>
<summary>Reveal answer</summary>

**Short answer:** Data races. Enable in Scheme. Run tests. Fix races.

**Key points:**
- TSan
- Data race
- Enable
- Fix

**Related to check:** Address Sanitizer, UBSan, Actor isolation rules

</details>

---

### UBSan

**Q:** What does Undefined Behavior Sanitizer catch?

<details>
<summary>Reveal answer</summary>

**Short answer:** Integer overflow, nil dereference. Undefined behavior. Enable in Scheme.

**Key points:**
- UBSan
- Overflow
- Nil
- Enable

**Related to check:** Address Sanitizer, Thread Sanitizer, Symbolication

</details>

---

### Memory Warning Handling

**Q:** How do you handle didReceiveMemoryWarning?

<details>
<summary>Reveal answer</summary>

**Short answer:** Release caches. Clear images. Save state. Don't over-release.

**Key points:**
- didReceiveMemoryWarning
- Caches
- Images
- Balance

**Related to check:** Startup optimization, Image downsampling, Leaks instrument

</details>

---

### Image Downsampling

**Q:** How do you downsample images to reduce memory?

<details>
<summary>Reveal answer</summary>

**Short answer:** Create thumbnail with ImageIO. Decode at display size. Avoid loading full res.

**Key points:**
- ImageIO
- Thumbnail
- Decode
- Memory

**Related to check:** Lazy loading strategy, Reduce binary size, CollectionView prefetching

</details>

---

### Lazy Loading Strategy

**Q:** What's a good lazy loading strategy for images?

<details>
<summary>Reveal answer</summary>

**Short answer:** Load on demand. Cache. Cancel when off-screen. Prefetch nearby.

**Key points:**
- On demand
- Cache
- Cancel
- Prefetch

**Related to check:** Image downsampling, CollectionView prefetching, Response caching

</details>

---

### CADisplayLink

**Q:** What is CADisplayLink? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Sync with display refresh. 60/120 fps. Use for animations, games. Avoid for general timers.

**Key points:**
- Display sync
- FPS
- Animation
- When to use

**Related to check:** CATransaction, UIView animations, Metal GPU

</details>

---

### CATransaction

**Q:** How do you batch Core Animation changes?

<details>
<summary>Reveal answer</summary>

**Short answer:** CATransaction.begin/commit. Group animations. Disable actions. Atomic updates.

**Key points:**
- begin/commit
- Group
- disableActions
- Atomic

**Related to check:** CADisplayLink, UIView animations, Core Animation

</details>

---

### Energy Log

**Q:** What does the Energy Log show?

<details>
<summary>Reveal answer</summary>

**Short answer:** CPU, network, location. Find battery drain. Optimize.

**Key points:**
- Energy
- Battery
- Drain
- Optimize

**Related to check:** Startup optimization, Lazy loading strategy, CADisplayLink

</details>

---

### Metal and GPU

**Q:** When would you use Metal for performance?

<details>
<summary>Reveal answer</summary>

**Short answer:** GPU compute. Image processing. Games. Offload from CPU.

**Key points:**
- Metal
- GPU
- Compute
- When

**Related to check:** Canvas drawing, CADisplayLink, Image downsampling

</details>

---

### Reduce Binary Size

**Q:** How do you reduce app binary size?

<details>
<summary>Reveal answer</summary>

**Short answer:** Strip symbols. App thinning. Remove unused. Compress assets.

**Key points:**
- Strip
- Thinning
- Unused
- Assets

**Related to check:** Startup optimization, Image downsampling, Lazy loading strategy

</details>

---

### Startup Optimization

**Q:** How do you measure and improve startup time?

<details>
<summary>Reveal answer</summary>

**Short answer:** MetricKit, Instruments. Lazy init. Defer work. Reduce dylibs.

**Key points:**
- MetricKit
- Lazy
- Defer
- dylibs

**Related to check:** Lazy loading strategy, Memory warning handling, Reduce binary size

</details>

---

## Data Persistence

### UserDefaults

**Q:** What is UserDefaults? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** UserDefaults is a key-value store for small amounts of user preferences and app settings. It persists across app launches. Backed by a plist file in the app's Library/Preferences directory.

**Key points:**
- Key-value store
- Plist-backed
- Survives app restart
- Simple types: String, Int, Bool, Data, Date, arrays/dictionaries of those
- Not for large data or sensitive data

**Related to check:** @AppStorage, Keychain, Core Data, Testing UserDefaults

</details>

---

### When to Use UserDefaults

**Q:** When should you use UserDefaults versus Core Data or Keychain?

<details>
<summary>Reveal answer</summary>

**Short answer:** UserDefaults for small, simple preferences. Core Data for structured, queryable data. Keychain for secrets and credentials.

**Key points:**
- UserDefaults: preferences, settings, small flags
- Core Data: entities, relationships, queries, large datasets
- Keychain: passwords, tokens, certificates
- File storage: documents, caches, user files

**Related to check:** UserDefaults, Core Data, Keychain, File storage

</details>

---

### Core Data

**Q:** What is Core Data? How does it differ from a database?

<details>
<summary>Reveal answer</summary>

**Short answer:** Core Data is Apple's object graph and persistence framework. It manages object lifecycle, relationships, and persistence—typically to SQLite. It's not a database; it's an ORM-like layer that can use SQLite, XML, or in-memory stores.

**Key points:**
- Object graph (NSManagedObject instances)
- Persistence stack: NSManagedObjectModel, NSPersistentStoreCoordinator, NSManagedObjectContext
- Default store: SQLite
- Handles relationships, faulting, change tracking
- Supports migrations, lightweight and custom

**Related to check:** NSManagedObject, Persistent Container, Fetch Request, Faulting, Migration

</details>

---

### NSManagedObject

**Q:** What is NSManagedObject? How does it relate to Core Data entities?

<details>
<summary>Reveal answer</summary>

**Short answer:** NSManagedObject is the base class for Core Data entities. Each instance represents a row in the store, with attributes and relationships defined in the data model. The context tracks changes for persistence.

**Key points:**
- Subclass of NSObject; one instance per entity instance
- Attributes and relationships from .xcdatamodeld
- Managed by NSManagedObjectContext
- Key-value coding for attribute access
- Can be a fault (lazy-loaded from store)

**Related to check:** Core Data, Persistent Container, Fetch Request, Faulting

</details>

---

### Persistent Container

**Q:** What is NSPersistentContainer? How do you set it up?

<details>
<summary>Reveal answer</summary>

**Short answer:** NSPersistentContainer bundles the Core Data stack: managed object model, persistent store coordinator, and a main-queue context. It simplifies setup and provides viewContext plus background task support.

**Key points:**
- Loads .xcdatamodeld by name
- Creates NSPersistentStoreCoordinator and default SQLite store
- viewContext: main-queue context for UI
- performBackgroundTask: creates temporary context for async work
- newBackgroundContext: long-lived background context

**Related to check:** Core Data, NSManagedObjectContext, Migration

</details>

---

### Fetch Request

**Q:** What is NSFetchRequest? How do you use it to query Core Data?

<details>
<summary>Reveal answer</summary>

**Short answer:** NSFetchRequest defines a query: entity type, predicate (filter), sort descriptors, and options like batch size. Execute with context.fetch(request) to get [NSManagedObject] or a subclass.

**Key points:**
- Entity: which type to fetch
- NSPredicate: filter (e.g. name == %@, age > 18)
- NSSortDescriptor: order
- fetchLimit, fetchBatchSize for performance
- Returns array of managed objects in the context

**Related to check:** Core Data, NSPredicate, Faulting, Core Data Performance

</details>

---

### Core Data Faulting

**Q:** What is Core Data faulting? Why does it matter?

<details>
<summary>Reveal answer</summary>

**Short answer:** Faulting is lazy loading. A fault is a placeholder—Core Data hasn't loaded the object's data from the store yet. Accessing a property 'fires' the fault and loads the data. Reduces memory and speeds fetches.

**Key points:**
- Fault: placeholder, not yet loaded
- Fire fault: access property → load from store
- Fetched objects can be faults until accessed
- Relationship access can fire faults (N+1 if not prefetched)
- refreshObject(_, mergeChanges:) can turn object back to fault

**Related to check:** Core Data, Fetch Request, Core Data Performance

</details>

---

### Core Data Migration

**Q:** What is Core Data migration? How do you handle schema changes?

<details>
<summary>Reveal answer</summary>

**Short answer:** Migration updates the persistent store when the data model changes. Lightweight migration handles additive changes (new attribute, new entity). Heavy migration uses mapping models for renames, splits, or complex changes.

**Key points:**
- Lightweight: add attribute/entity, add optional relationship
- Heavy: rename, split entity, change type, delete attribute
- NSMappingModel for custom mappings
- NSMigratePersistentStoresAutomaticallyOption
- Versioned models: .xcdatamodeld contains multiple versions

**Related to check:** Core Data, Persistent Container, NSPersistentStoreCoordinator

</details>

---

### SQLite on iOS

**Q:** What is SQLite? When would you use it directly instead of Core Data?

<details>
<summary>Reveal answer</summary>

**Short answer:** SQLite is an embedded, file-based relational database. On iOS it's available via the sqlite3 C API or wrappers like GRDB, SQLite.swift. Use directly when you need raw SQL, portability, or minimal overhead; Core Data when you want object graph, relationships, and Apple integration.

**Key points:**
- Single file, no server
- ACID transactions
- SQL queries
- Core Data uses SQLite as default store
- Direct use: full SQL control, cross-platform, lightweight

**Related to check:** Core Data, Realm, File storage

</details>

---

### Realm

**Q:** What is Realm? How does it compare to Core Data?

<details>
<summary>Reveal answer</summary>

**Short answer:** Realm is a cross-platform object database. You define Swift classes (or structs with RealmSwift), and Realm persists them. Lazy loading, live objects (auto-updating), and a simpler API than Core Data. Used by many production apps.

**Key points:**
- Object database (not ORM over SQLite)
- Realm Swift: classes inherit Object, properties are persisted
- Live objects: results update when data changes
- Cross-platform (iOS, Android, etc.)
- No NSManagedObjectContext; write transactions

**Related to check:** Core Data, SQLite, Object database

</details>

---

### File Storage

**Q:** How do you store files on iOS? What are the main directories?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use FileManager to read and write files. Key directories: Documents (user data, backed up), Library/Caches (temporary, not backed up), tmp (cleared by system). App sandbox restricts access to other apps.

**Key points:**
- FileManager.default
- Documents: user-visible, backed up to iCloud
- Library/Caches: cache, not backed up
- tmp: temporary, system may delete
- Application Support: app-created files, backed up
- Sandbox: app can only access its container

**Related to check:** UserDefaults, Keychain, Core Data, NSCache

</details>

---

### Keychain

**Q:** What is the Keychain? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Keychain is an encrypted storage for sensitive data: passwords, tokens, certificates. Data is encrypted at rest, survives app reinstall (when using kSecAttrAccessible), and can be shared via app groups. Use for credentials, API keys, certificates.

**Key points:**
- Encrypted storage
- SecItemAdd, SecItemCopyMatching, SecItemUpdate, SecItemDelete
- kSecClass: generic password, certificate, key, identity
- kSecAttrAccessible: when unlocked, after first unlock, etc.
- App groups for sharing with extensions

**Related to check:** UserDefaults, Secrets Management, Security framework

</details>

---

### Securing Sensitive Data

**Q:** How do you secure sensitive data in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Store credentials and secrets in Keychain. Never commit secrets to source control. Use build config or remote config for API keys. Obfuscation is not security—encryption is. Use Data Protection (encryption at rest) for files.

**Key points:**
- Keychain for passwords, tokens, certificates
- Never UserDefaults or plist for secrets
- Env vars, xcconfig (not committed) for build-time secrets
- Remote config for keys that can change
- Data Protection: complete, completeUnlessOpen, etc.
- Certificate pinning for network

**Related to check:** Keychain, Secrets Management, Certificate Pinning

</details>

---

### Data Synchronization

**Q:** How would you sync data across devices or with a backend?

<details>
<summary>Reveal answer</summary>

**Short answer:** Local-first: store in Core Data/Realm; sync in background. Use timestamps or version vectors for conflict resolution. Push changes to backend; pull and merge. Consider CloudKit, Firebase, or custom REST/GraphQL with sync protocol.

**Key points:**
- Local source of truth; network syncs when available
- Last-write-wins vs merge strategies
- Delta sync: only changed records
- Conflict resolution: timestamp, vector clock, or server wins
- Offline queue: queue mutations when offline, sync when online

**Related to check:** Offline-First, Core Data, Networking, CloudKit

</details>

---

### Offline Persistence

**Q:** What is offline persistence? How do you design for it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Offline persistence means the app works without network. Local storage (Core Data, Realm, SQLite) is the source of truth. Fetch from network when available; cache responses. Queue mutations (create, update, delete) and sync when online. Show cached data immediately.

**Key points:**
- Local-first: data lives in Core Data/Realm/SQLite
- Cache API responses; serve from cache when offline
- Mutation queue: store pending changes, sync later
- Optimistic UI: show local state; reconcile on sync
- Conflict resolution when sync completes

**Related to check:** Offline-First, Data Synchronization, Core Data, Caching

</details>

---

## Testing

### Unit Testing

**Q:** What is unit testing? How do you write unit tests in Swift?

<details>
<summary>Reveal answer</summary>

**Short answer:** Unit tests verify small units (functions, classes) in isolation. Use XCTest. Test one behavior per test. Use XCTAssert. Mock dependencies. Run fast, no UI.

**Key points:**
- XCTest framework
- test prefix, throws
- XCTAssertEqual, XCTAssertTrue, etc.
- Mock dependencies via protocols

**Related to check:** XCTest, mocking, TDD

</details>

---

### Mocking and Stubbing

**Q:** How do you mock dependencies in tests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use protocols for dependencies. Create mock/stub that conforms and returns predefined values. Inject mock in test. Verify calls (optional). Use for: API, database, time.

**Key points:**
- Protocol defines interface
- Mock: returns test data
- Stub: minimal implementation
- Inject via init

**Related to check:** Dependency injection, protocols, unit testing

</details>

---

### UI Testing

**Q:** What is UI testing? How does it differ from unit testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** UI testing automates the app UI. Uses XCUITest. Launches app, taps, types, asserts UI state. Slower, flaky. Use for critical flows. Unit tests for logic; UI tests for E2E.

**Key points:**
- XCUITest
- app.buttons["Login"].tap()
- Accessibility identifiers
- Launches real app

**Related to check:** XCUITest, accessibility, E2E

</details>

---

### XCTest and Async

**Q:** How do you test async code with XCTest?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use async test functions. Mark test as async throws. Use await. Use XCTestExpectation for callback-based code. Use Task for fire-and-forget. Swift 5.5+ supports async tests.

**Key points:**
- func testX() async throws
- await in test
- expectation + fulfill for callbacks
- Task for detached work

**Related to check:** async/await, XCTestExpectation

</details>

---

### ViewModel Testing

**Q:** How do you test a ViewModel?

<details>
<summary>Reveal answer</summary>

**Short answer:** Inject mock dependencies. Call methods. Assert @Published state. Use combine or direct property observation. No UI. Test business logic, state transitions, error handling.

**Key points:**
- Mock API, repository
- Call load(), etc.
- Assert viewModel.items, viewModel.isLoading
- Test error paths

**Related to check:** MVVM, mocking, unit testing

</details>

---

### Snapshot Testing

**Q:** What is snapshot testing? When would you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Snapshot testing captures UI output and compares to stored image. First run creates snapshot; subsequent runs compare. Detects unintended UI changes. Use SwiftSnapshotTesting or similar.

**Key points:**
- Record then assert
- Image or hierarchy
- Fails on diff
- Update snapshots when intentional

**Related to check:** UI testing, regression, SwiftUI

</details>

---

### TDD

**Q:** What is TDD? Describe the red-green-refactor cycle.

<details>
<summary>Reveal answer</summary>

**Short answer:** TDD: write test first, then code. Red: write failing test. Green: minimal code to pass. Refactor: improve. Repeat. Ensures testability and design.

**Key points:**
- Test first
- Red-Green-Refactor
- Small steps
- Design emerges from tests

**Related to check:** Unit testing, red-green-refactor

</details>

---

### Accessibility Identifiers

**Q:** Why use accessibility identifiers for UI testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Accessibility identifiers provide stable, unique selectors for UI elements. Use accessibilityIdentifier. Avoid relying on labels (can change). Enables reliable UI tests. Also helps VoiceOver.

**Key points:**
- accessibilityIdentifier
- app.buttons["loginButton"]
- Stable across localization
- Not user-visible

**Related to check:** UI testing, accessibility

</details>

---

### Test Doubles: Mock, Stub, Spy, Fake

**Q:** What's the difference between mock, stub, spy, and fake?

<details>
<summary>Reveal answer</summary>

**Short answer:** Stub: returns predefined values. Mock: verifies interactions. Spy: records calls for assertion. Fake: working implementation (e.g., in-memory DB). Use based on what you need to verify.

**Key points:**
- Stub: control input
- Mock: verify calls
- Spy: record + verify
- Fake: real behavior, simplified

**Related to check:** Mocking, unit testing

</details>

---

### Code Coverage

**Q:** What is code coverage? How do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Coverage measures which code runs during tests. Line, branch, function. Enable in scheme (Test → Options → Code Coverage). Use to find untested code. Don't chase 100% blindly.

**Key points:**
- Enable in scheme
- View in Report navigator
- Line, branch coverage
- Guide, not goal

**Related to check:** XCTest, quality

</details>

---

### Quick and Nimble

**Q:** What are Quick and Nimble? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Quick: BDD-style test framework (describe, it, beforeEach). Nimble: matchers (expect(x).to(equal(5))). More readable. Alternative to XCTest. Use for BDD style or better matchers.

**Key points:**
- describe/it blocks
- expect().to()
- Async matchers
- Third-party dependency

**Related to check:** BDD, XCTest, matchers

</details>

---

### URLProtocol for Mocking Network

**Q:** How do you use URLProtocol to mock network requests?

<details>
<summary>Reveal answer</summary>

**Short answer:** URLProtocol intercepts URL loading. Register a custom protocol that returns canned responses. No real network. Use for integration tests. Implement canInit, canonicalRequest, startLoading.

**Key points:**
- Subclass URLProtocol
- Register with URLProtocol.registerClass
- Return canned data
- Unregister after test

**Related to check:** URLSession, mocking, integration tests

</details>

---

### ViewController Testing

**Q:** How do you test a UIViewController?

<details>
<summary>Reveal answer</summary>

**Short answer:** Load view (loadViewIfNeeded), inject dependencies, trigger actions, assert state or view hierarchy. Use XCTest. Consider testing ViewModel separately. Use UIViewController lifecycle for load.

**Key points:**
- loadViewIfNeeded()
- Inject mock dependencies
- Trigger actions (button tap)
- Assert labels, state

**Related to check:** UIKit, unit testing, loadViewIfNeeded

</details>

---

### SwiftUI Preview as Test

**Q:** Can you use SwiftUI Previews for testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Previews are for visual verification, not automated tests. They don't run in CI. Use for quick iteration. For testing: use ViewInspector or unit test ViewModel. Previews complement, don't replace tests.

**Key points:**
- Previews: manual, visual
- Not automated
- ViewInspector for SwiftUI view testing
- ViewModel tests for logic

**Related to check:** SwiftUI, previews, ViewInspector

</details>

---

### Parameterized Tests

**Q:** How do you run the same test with different inputs?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use a loop over test cases, or XCTContext.runActivity. Create array of (input, expected). Loop and assert. Or use Swift's for-in with test data. Keeps tests DRY.

**Key points:**
- Array of (input, expected)
- for (input, expected) in cases
- One test, many scenarios
- Clear failure messages

**Related to check:** Unit testing, test data

</details>

---

### CI and Automated Testing

**Q:** How do you run tests in CI?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use xcodebuild test. Fastlane, GitHub Actions, Xcode Cloud. Run on every PR. Use simulators. Split unit vs UI tests. Cache dependencies. Report results.

**Key points:**
- xcodebuild -scheme App -destination 'platform=iOS Simulator' test
- Fastlane: scan
- Xcode Cloud: built-in
- Parallelize when possible

**Related to check:** Fastlane, Xcode Cloud, xcodebuild

</details>

---

### Test Naming Conventions

**Q:** What naming conventions do you use for tests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Name should describe behavior: testUserDisplayNameWhenLoggedIn, testLoadShowsErrorWhenNetworkFails. Pattern: test[Unit]_[Scenario]_[ExpectedResult]. Or Given-When-Then in name. Failures should be clear from name.

**Key points:**
- test + method/unit + scenario + result
- Descriptive
- Read as specification
- No abbreviations

**Related to check:** Unit testing, BDD

</details>

---

### XCTest Assertions

**Q:** What XCTest assertions do you use? When?

<details>
<summary>Reveal answer</summary>

**Short answer:** XCTAssertEqual for equality. XCTAssertTrue/False for booleans. XCTAssertNil/NotNil for optionals. XCTAssertThrowsError for errors. XCTAssertNoThrow. Use most specific assertion.

**Key points:**
- XCTAssertEqual, XCTAssertNotEqual
- XCTAssertTrue, XCTAssertFalse
- XCTAssertNil, XCTAssertNotNil
- XCTAssertThrowsError

**Related to check:** XCTest, assertions

</details>

---

### setUp and tearDown

**Q:** When do you use setUp and tearDown?

<details>
<summary>Reveal answer</summary>

**Short answer:** setUp runs before each test; tearDown after. Use for: creating fresh instances, resetting mocks, registering URLProtocol. Ensures test isolation. Don't share state between tests.

**Key points:**
- override func setUp()
- override func tearDown()
- Fresh state per test
- Unregister, cleanup

**Related to check:** XCTest, isolation

</details>

---

### Integration Testing

**Q:** What is integration testing? How does it differ from unit testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Integration tests verify multiple components together. Real or fake dependencies. E.g., ViewModel + Repository + Mock API. More realistic, slower. Use for critical paths. Unit tests are isolated.

**Key points:**
- Multiple components
- Real or fake (in-memory DB)
- Slower than unit
- Catches integration bugs

**Related to check:** Unit testing, mocking, E2E

</details>

---

### Testing Async ViewModels

**Q:** How do you test a ViewModel with async methods?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use async test. await viewModel.load(). Use mock that returns immediately. For @MainActor ViewModel, use @MainActor on test or MainActor.assumeIsolated. Assert after await.

**Key points:**
- func testX() async throws
- await viewModel.load()
- Mock returns quickly
- @MainActor if needed

**Related to check:** async/await, ViewModel, @MainActor

</details>

---

### Testing Error Paths

**Q:** How do you test error handling?

<details>
<summary>Reveal answer</summary>

**Short answer:** Mock returns error. Call method. Assert error state (message, retry visibility). Use XCTAssertThrowsError for throwing. Test each error type. Don't only test happy path.

**Key points:**
- Mock throws or returns .failure
- Assert error state
- XCTAssertThrowsError
- Test user-facing behavior

**Related to check:** Mocking, error handling, ViewModel

</details>

---

### Designing for Testability

**Q:** How do you design code to be testable?

<details>
<summary>Reveal answer</summary>

**Short answer:** Depend on protocols, inject dependencies. Avoid singletons, static calls. Small, focused units. Pure functions when possible. Separate side effects. Use dependency injection.

**Key points:**
- Protocol for dependencies
- Inject via init
- Avoid global state
- Pure functions

**Related to check:** Dependency injection, SOLID

</details>

---

### Flaky Tests

**Q:** What causes flaky tests? How do you fix them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Flaky: pass sometimes, fail sometimes. Causes: timing, shared state, order dependency, external services. Fix: remove timing (use deterministic mock), isolate state, run in random order.

**Key points:**
- Timing: async, animations
- Shared state
- Order dependency
- External (network, date)

**Related to check:** Unit testing, async, mocking

</details>

---

### Testing Delegate Pattern

**Q:** How do you test code that uses delegates?

<details>
<summary>Reveal answer</summary>

**Short answer:** Create a test delegate that records calls. Conform to protocol, store invoked methods and parameters. Inject or set as delegate. Trigger action. Assert delegate was called with expected values.

**Key points:**
- Test delegate conforms to protocol
- Records calls (e.g., didSelectItem)
- Set as delegate
- Assert after action

**Related to check:** Delegate pattern, mocking

</details>

---

### Performance Testing

**Q:** How do you add performance tests in XCTest?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use measure(metrics:block:). Runs block multiple times, reports average. Use for: algorithm speed, parsing. Set baseline. Fails if regression. Use XCTClockMetric, XCTMemoryMetric.

**Key points:**
- measure { }
- Baseline for comparison
- Multiple iterations
- Metrics: time, memory

**Related to check:** XCTest, measure, performance

</details>

---

### Testing Combine Publishers

**Q:** How do you test Combine publishers?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use .sink or .first() to get values. Use expectation. Or use Combine's test utilities. For ViewModel: subscribe to @Published, assert values. Use receive(on:) for main thread.

**Key points:**
- .sink to consume
- XCTestExpectation
- .first() for single value
- Test scheduler (if available)

**Related to check:** Combine, XCTestExpectation

</details>

---

### Test Plans

**Q:** What are Xcode Test Plans? When would you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Test plans (.xctestplan) configure which tests run, in what order, with what options. Separate unit vs UI. Different configs for CI vs local. Run subsets. Configure parallelization.

**Key points:**
- .xctestplan file
- Test targets, test classes
- Options: parallel, random order
- Multiple configurations

**Related to check:** XCTest, CI, schemes

</details>

---

### Testing Code That Uses Singletons

**Q:** How do you test code that uses singletons?

<details>
<summary>Reveal answer</summary>

**Short answer:** Inject the singleton as a dependency (protocol). Or use a shared instance that can be swapped in tests. Or refactor to remove singleton. Avoid static/global in production code when testability matters.

**Key points:**
- Inject protocol wrapping singleton
- Swappable for test
- Refactor to DI
- Test double for singleton

**Related to check:** Dependency injection, singletons

</details>

---

### Testing Code That Uses UserDefaults

**Q:** How do you test code that uses UserDefaults?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use a custom suite name for tests: UserDefaults(suiteName: \"Test\"). Inject UserDefaults as dependency. Or use in-memory suite. Clear in tearDown. Prevents polluting real UserDefaults.

**Key points:**
- UserDefaults(suiteName: "Test")
- Inject as dependency
- Clear in tearDown
- Isolated from app

**Related to check:** UserDefaults, dependency injection

</details>

---

### Given-When-Then

**Q:** What is the Given-When-Then pattern?

<details>
<summary>Reveal answer</summary>

**Short answer:** Structure tests: Given setup, When action, Then assert. Readable. BDD style.

**Key points:**
- Given
- When
- Then
- Readable

**Related to check:** XCTContext runActivity, Test fixtures, Test discovery

</details>

---

### Test Fixtures

**Q:** What are test fixtures? How do you use them?

<details>
<summary>Reveal answer</summary>

**Short answer:** Reusable test data. Factory methods. Shared setup. Avoid duplication.

**Key points:**
- Fixtures
- Factory
- Setup
- Reuse

**Related to check:** Test isolation, Fake vs mock, Given-when-then

</details>

---

### Golden File Testing

**Q:** What is golden file testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Compare output to saved file. For serialization, rendering. Update when intentional.

**Key points:**
- Golden
- Snapshot
- Update
- When

**Related to check:** Screenshot testing, Test fixtures, Contract testing

</details>

---

### Mutation Testing

**Q:** What is mutation testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Mutate code, run tests. If tests pass, weak. Improves coverage quality.

**Key points:**
- Mutate
- Kill
- Quality
- Tools

**Related to check:** Test pyramid, Test isolation, Golden file testing

</details>

---

### Contract Testing

**Q:** What is contract testing?

<details>
<summary>Reveal answer</summary>

**Short answer:** Test API contract. Consumer and provider. Pact. Ensure compatibility.

**Key points:**
- Contract
- Pact
- Consumer
- Provider

**Related to check:** API documentation, API mocking strategy, Fake vs mock

</details>

---

### Test Pyramid

**Q:** What is the test pyramid?

<details>
<summary>Reveal answer</summary>

**Short answer:** Many unit, fewer integration, few E2E. Fast feedback. Stable.

**Key points:**
- Unit
- Integration
- E2E
- Ratio

**Related to check:** Test isolation, Contract testing, Screenshot testing

</details>

---

### Fake vs Mock

**Q:** What's the difference between a fake and a mock?

<details>
<summary>Reveal answer</summary>

**Short answer:** Fake: working impl. Mock: verifies calls. Use fake for speed, mock for behavior.

**Key points:**
- Fake
- Mock
- When each
- Verify

**Related to check:** Test doubles best practices, Contract testing, Test fixtures

</details>

---

### Test Isolation

**Q:** Why is test isolation important?

<details>
<summary>Reveal answer</summary>

**Short answer:** Tests shouldn't affect each other. Fresh state. Order-independent. Reliable.

**Key points:**
- Isolation
- Fresh
- Order
- Reliable

**Related to check:** Test fixtures, Refactoring for testability, Fake vs mock

</details>

---

### Async Testing Patterns

**Q:** How do you test async code in XCTest?

<details>
<summary>Reveal answer</summary>

**Short answer:** async/await. Task. Expectations. MainActor.assumeIsolated.

**Key points:**
- async
- Task
- Expectation
- MainActor

**Related to check:** Test isolation, Fake vs mock, Contract testing

</details>

---

### XCTUnwrap

**Q:** What is XCTUnwrap? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Unwraps optional or fails test. Cleaner than guard/force. Use in tests.

**Key points:**
- XCTUnwrap
- Optional
- Fail
- Clean

**Related to check:** XCTContext runActivity, Test discovery, Given-when-then

</details>

---

### XCTExpectFailure

**Q:** What is XCTExpectFailure?

<details>
<summary>Reveal answer</summary>

**Short answer:** Marks known failure. For flaky or WIP. Temporary.

**Key points:**
- Expect failure
- Known
- Temporary
- When

**Related to check:** Test isolation, XCTUnwrap, Test plans config

</details>

---

### Test Discovery

**Q:** How does XCTest discover tests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Subclass XCTestCase. Methods starting with test. Runtime discovery.

**Key points:**
- XCTestCase
- test prefix
- Discovery
- Runtime

**Related to check:** Swift Testing, XCTUnwrap, Test plans config

</details>

---

### XCTContext runActivity

**Q:** What is XCTContext.runActivity?

<details>
<summary>Reveal answer</summary>

**Short answer:** Groups assertions. Better failure messages. Structure. Nested.

**Key points:**
- runActivity
- Group
- Messages
- Structure

**Related to check:** Given-when-then, XCTUnwrap, Test discovery

</details>

---

### Test Plans Configuration

**Q:** How do you configure test plans?

<details>
<summary>Reveal answer</summary>

**Short answer:** Xcode test plans. Multiple configs. Environment. Selective run.

**Key points:**
- Test plan
- Config
- Environment
- Selective

**Related to check:** Test isolation, API mocking strategy, Test pyramid

</details>

---

### Swift Testing Framework

**Q:** What is the Swift Testing framework?

<details>
<summary>Reveal answer</summary>

**Short answer:** Swift 6+. @Test. Parameterized. Traits. Modern alternative to XCTest.

**Key points:**
- @Test
- Parameterized
- Traits
- Swift 6

**Related to check:** XCTest, Test discovery, Given-when-then

</details>

---

### UI Test Identifiers

**Q:** How do you choose accessibility identifiers for UI tests?

<details>
<summary>Reveal answer</summary>

**Short answer:** Unique, stable. Don't use text. Use semantic IDs. accessibilityIdentifier.

**Key points:**
- accessibilityIdentifier
- Stable
- Unique
- Semantic

**Related to check:** Accessibility, Screenshot testing, UI testing

</details>

---

### Screenshot Testing

**Q:** What is screenshot testing? When do you use it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Capture UI, compare. Visual regression. Use for critical screens.

**Key points:**
- Screenshot
- Compare
- Regression
- When

**Related to check:** Golden file testing, UI test identifiers, Test pyramid

</details>

---

### Test Doubles Best Practices

**Q:** What are best practices for test doubles?

<details>
<summary>Reveal answer</summary>

**Short answer:** Minimal. Protocol-based. Don't over-mock. Test behavior.

**Key points:**
- Minimal
- Protocol
- Behavior
- Avoid over-mock

**Related to check:** Fake vs mock, Refactoring for testability, Test fixtures

</details>

---

### Refactoring for Testability

**Q:** How do you refactor legacy code for testability?

<details>
<summary>Reveal answer</summary>

**Short answer:** Extract dependencies. Inject. Introduce protocols. Small steps.

**Key points:**
- Extract
- Inject
- Protocols
- Incremental

**Related to check:** Test doubles best practices, Fake vs mock, Test isolation

</details>

---

## System Design

### Image Caching System

**Q:** Design an image caching system for an iOS app.

<details>
<summary>Reveal answer</summary>

**Short answer:** Multi-level cache: memory (NSCache) for hot images, disk for persistence. Check memory first, then disk, then network. Decode on background thread. Limit memory and disk size; evict LRU or by TTL. Consider downsampling for thumbnails.

**Key points:**
- Memory: NSCache (evicts on pressure)
- Disk: FileManager in Caches, keyed by URL hash
- Async loading; cancel in-flight when cell reused
- Downsampling for large images (UIGraphicsImageRenderer)
- Placeholder while loading

**Related to check:** NSCache, Image Loading and Caching, Scroll Performance

</details>

---

### Scalable Chat App

**Q:** Design a scalable chat app. How would you architect it?

<details>
<summary>Reveal answer</summary>

**Short answer:** Local-first: Core Data/Realm for messages. WebSocket or long-poll for real-time. Paginate history (fetch older on scroll). Optimistic UI: show sent immediately, reconcile on ack. Sync protocol: delta sync, last-seen cursor. Consider push for background.

**Key points:**
- Local store: messages, conversations, read state
- Real-time: WebSocket preferred; fallback long-poll
- Pagination: cursor-based, load older
- Optimistic sends; retry on failure
- Push for notifications when app backgrounded
- Offline: queue sends, sync when online

**Related to check:** WebSockets, Offline-First, Data Synchronization, Pagination

</details>

---

### Feed Loading (Instagram-style)

**Q:** How would you build Instagram-style feed loading?

<details>
<summary>Reveal answer</summary>

**Short answer:** Prefetch next page before user reaches bottom. Cache images in memory + disk. Lazy load cells; cancel requests on reuse. Show skeleton or placeholder. Paginate with cursor (max_id or offset). Prioritize visible cells; prefetch below fold.

**Key points:**
- Cursor-based pagination (cursor or offset)
- Prefetch: load next page when N items from bottom
- Image cache: memory + disk; downsampling
- Cell reuse: cancel in-flight image load on dequeue
- Skeleton/placeholder for perceived performance
- Diffable data source for smooth updates

**Related to check:** Pagination, Image Caching, Scroll Performance, Diffable Data Source

</details>

---

### Offline Mode Design

**Q:** How would you design offline mode for an app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Local storage is source of truth. Fetch from network when available; merge into local store. Queue mutations (create, update, delete) when offline; sync when online. Show cached data immediately; indicate sync status. Handle conflicts with defined strategy (merge, server wins, last-write-wins).

**Key points:**
- Core Data/Realm/SQLite for local data
- Network layer: check cache first, then API
- Mutation queue: persist pending changes, retry on connect
- Conflict resolution: timestamp, version vector, or server wins
- UI: show cached; badge or banner for sync state
- Reachability: observe network changes; trigger sync

**Related to check:** Offline-First, Data Synchronization, Core Data, Caching

</details>

---

### Push Notification System

**Q:** Design a push notification system for an iOS app.

<details>
<summary>Reveal answer</summary>

**Short answer:** APNs for delivery. App registers for remote notifications; receives device token. Send token to your backend. Backend stores token per user; sends via APNs when event occurs. Handle notification in foreground (willPresent), background (didReceive), and tapped (userNotificationCenter). Support silent push for data sync.

**Key points:**
- APNs: Apple Push Notification service
- Device token: register, send to backend
- Payload: alert, badge, sound, data
- Silent push: content-available for background fetch
- Notification Service Extension: modify content, download media
- Categories/actions for interactive notifications

**Related to check:** APNs, Background Modes, NotificationCenter

</details>

---

### Pagination Design

**Q:** How would you implement pagination in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Cursor-based or offset-based. Cursor: pass last item ID or timestamp; server returns next page. Offset: page number and limit. Prefetch next page before user reaches end. Store in local cache (Core Data, array); append on load. Use UICollectionViewDataSourcePrefetching or scroll position.

**Key points:**
- Cursor: stable, handles inserts/deletes; offset can skip/duplicate
- Prefetch: load when N items from bottom
- Append to data source; update UI (diffable or reload)
- Loading indicator; handle empty and error
- Cache pages locally for offline

**Related to check:** Networking, Diffable Data Source, Offline Persistence

</details>

---

### Modular App Architecture

**Q:** How would you architect a modular iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Feature modules: each module is a Swift package or framework. Modules expose protocols; depend on abstractions, not implementations. Main app composes modules. Shared module for common types, networking, persistence. Dependency injection at app boundary.

**Key points:**
- Swift Package or XCFramework per feature
- Public API: protocols, not concrete types
- Dependencies: module A depends on module B's protocol only
- Main app: wires modules via DI
- Shared: networking, persistence, UI components
- Build time: compile modules in parallel

**Related to check:** Modular Architecture, Dependency Injection, Clean Architecture

</details>

---

### Analytics Implementation

**Q:** How would you implement analytics in an iOS app?

<details>
<summary>Reveal answer</summary>

**Short answer:** Protocol-based analytics service; inject at app init. Events: screen view, user action, timing. Queue events; batch upload. Persist queue for offline; retry on failure. Support multiple providers (Firebase, Mixpanel, custom). Don't block main thread; fire-and-forget.

**Key points:**
- Protocol: AnalyticsService with track(event:properties:)
- Event schema: name, properties, timestamp
- Queue: store locally; flush when batch size or time
- Offline: persist queue; send when online
- Privacy: respect ATT; don't track PII without consent
- Testing: mock implementation

**Related to check:** Analytics Architecture, Logging, Dependency Injection

</details>

---

### Infinite Scroll Feed

**Q:** How would you build an infinite scroll feed?

<details>
<summary>Reveal answer</summary>

**Short answer:** Load initial page; prefetch next when user nears bottom (e.g. 5 items from end). Append to data source; update UI. Cursor-based pagination preferred. Cancel in-flight requests if user scrolls away quickly. Cache loaded pages; show cached first on return. Use diffable data source for smooth updates.

**Key points:**
- Initial load: first page
- Prefetch: trigger when index >= count - N
- Append: add to array; apply snapshot or reload
- Loading indicator at bottom while fetching
- Cache: memory or disk for visited pages
- Handle: empty, error, no more pages

**Related to check:** Pagination, Feed Loading, Diffable Data Source

</details>

---

### Caching Layer Design

**Q:** Design a caching layer for an iOS app.

<details>
<summary>Reveal answer</summary>

**Short answer:** Multi-level: L1 memory (NSCache), L2 disk (FileManager or SQLite). Cache-aside: check cache, on miss load from source, store in cache. TTL for expiration. Size limits; evict LRU or by cost. Key design: namespace, version for invalidation. Consider cache stampede: single flight for same key.

**Key points:**
- L1: NSCache (evicts on memory pressure)
- L2: disk in Caches directory
- Strategy: cache-aside, write-through, write-behind
- TTL: expire after time
- Eviction: LRU, LFU, or size-based
- Key: include version/namespace for invalidation

**Related to check:** NSCache, Caching Strategy, Image Caching

</details>

---

### App State Restoration

**Q:** How would you handle app state restoration?

<details>
<summary>Reveal answer</summary>

**Short answer:** Restore UI state when app relaunches. Encode navigation stack, scroll position, form state. Use state restoration APIs (UIViewController restorationIdentifier) or custom: save state to UserDefaults/plist on background, restore on launch. For complex state, persist to file or Core Data.

**Key points:**
- UIViewController: restorationIdentifier, encodeRestorableState
- Codable: encode navigation path, selected tab, scroll offset
- When: applicationDidEnterBackground or willResignActive
- What: tab, nav stack, scroll position, form data
- SwiftUI: SceneStorage, @SceneStorage for simple values
- Deep links: restore to specific screen

**Related to check:** App Lifecycle, Deep Linking, UserDefaults

</details>

---

### Background Uploads

**Q:** How would you handle background uploads?

<details>
<summary>Reveal answer</summary>

**Short answer:** Use URLSession background configuration. Create URLSession with background identifier; upload tasks continue when app is suspended. Implement application(_:handleEventsForBackgroundURLSession:completionHandler:) to receive completion. Store completion handler; call when all tasks finish. Persist task state for app termination.

**Key points:**
- URLSessionConfiguration.background(withIdentifier:)
- Upload tasks survive app suspend/terminate
- Completion handler in AppDelegate/SceneDelegate
- Save completion handler; call when session finishes
- Recreate session with same identifier on launch
- Handle task completion in URLSessionDelegate

**Related to check:** URLSession, Background Modes, Networking

</details>

---

### Feature Flags Design

**Q:** How would you design a feature flag system?

<details>
<summary>Reveal answer</summary>

**Short answer:** Remote config or custom API. Fetch flags on launch; cache locally for offline. Check flag before showing feature. Support user/segment overrides. Use for: gradual rollout, A/B tests, kill switch. Define flag lifecycle: create, enable, deprecate, remove.

**Key points:**
- Source: Firebase Remote Config, LaunchDarkly, or custom API
- Fetch on launch; cache with TTL
- Check: if flags.isEnabled(.newCheckout) { ... }
- Segments: user ID, app version, percentage rollout
- Local override for development
- Lifecycle: document and remove when stable

**Related to check:** Feature Flags, Remote Configuration, A/B Testing

</details>

---

### Remote Configuration

**Q:** How would you design remote configuration?

<details>
<summary>Reveal answer</summary>

**Short answer:** Fetch config from server on launch or periodically. Cache locally; use cached if fetch fails. Config: API URLs, feature toggles, limits, copy. Support app version, user segment. Don't block launch; apply config asynchronously. Use for: A/B tests, emergency switches, environment-specific values.

**Key points:**
- Fetch: on launch, or periodic, or on app resume
- Cache: UserDefaults or file; TTL
- Fallback: use cached if network fails
- Keys: API base URL, feature flags, limits
- Segmentation: by app version, user cohort
- Apply: update in-memory config; notify observers

**Related to check:** Feature Flags, Config Management, Networking

</details>

---

### Large Codebase Structure

**Q:** How would you structure a large iOS codebase?

<details>
<summary>Reveal answer</summary>

**Short answer:** Feature-based or layer-based. Feature: group by feature (Auth, Profile, Feed); each has views, view models, services. Layer: separate UI, domain, data. Use modules (SPM) for boundaries. Shared: networking, persistence, extensions. Clear dependency direction: UI → Domain → Data.

**Key points:**
- Feature folders: Auth/, Profile/, Feed/
- Or layers: UI/, Domain/, Data/
- Modules: Swift packages per feature or layer
- Shared: common types, networking, persistence
- DI: inject dependencies at composition root
- Naming: consistent (ViewController, ViewModel, Service)

**Related to check:** Modular Architecture, Clean Architecture, Code Organization

</details>

---
