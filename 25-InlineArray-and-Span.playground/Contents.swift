//: Playground Practice — InlineArray and Span (Swift 6.2, iOS 26+ runtime)
//: Rapid Sheet: "What are `InlineArray` and `Span` in Swift 6.2, and why were they added?"
//: InlineArray: fixed-size, stored inline (no heap). Span: safe, non-escaping view of contiguous memory.

import Foundation

// MARK: - InlineArray: the count is part of the type
var rgb: InlineArray<3, UInt8> = [255, 128, 0]
rgb[2] = 64
print("InlineArray<3, UInt8> size:", MemoryLayout<InlineArray<3, UInt8>>.size, "bytes")   // 3, no heap pointer

var squares = InlineArray<4, Int>(repeating: 0)
for i in squares.indices { squares[i] = i * i }      // index-based: for-in over InlineArray needs iOS 27
print("squares:", squares[0], squares[1], squares[2], squares[3])

// MARK: - Span: read a contiguous buffer without copying and without unsafe pointers
func checksum(_ bytes: Span<UInt8>) -> Int {
    var total = 0
    for i in bytes.indices { total &+= Int(bytes[i]) }
    return total
}

let data: [UInt8] = Array("Hello, Span".utf8)
print("checksum (Array):", checksum(data.span))
print("checksum (InlineArray):", checksum(rgb.span))

// ❌ A Span can't escape its scope (it's ~Escapable):
// var saved: Span<UInt8>? = nil
// saved = data.span            // error: lifetime-dependent value escapes its scope

//: Why: predictable performance without heap allocation or `withUnsafeBufferPointer`,
//: with bounds checks and lifetime rules the compiler enforces.
