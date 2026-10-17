//: Playground Practice — @concurrent and Isolation (Swift 6.2)
//: Rapid Sheet: "What does `@concurrent` do? In Swift 6.2, how do you run work off the main actor?"
//: `async` doesn't mean "background". Isolation decides where code runs; `@concurrent` opts out of the caller's actor.

import Foundation

struct Photo: Sendable { let id: Int; let pixels: [UInt8] }

// MARK: - CPU-heavy work marked @concurrent: always runs on the global concurrent executor
@concurrent
func makeThumbnail(_ photo: Photo) async -> Int {
    var sum = 0
    for p in photo.pixels { sum &+= Int(p) }      // stand-in for decoding/resizing
    return sum
}

@MainActor
final class GalleryModel {
    private(set) var thumbnails: [Int: Int] = [:]

    func load(_ photos: [Photo]) async {
        // We're on the main actor here. Each @concurrent call hops off it, then the result comes back.
        for photo in photos {
            let thumb = await makeThumbnail(photo)
            thumbnails[photo.id] = thumb               // back on the main actor: safe to update UI state
        }
    }
}

let photos = (1...3).map { Photo(id: $0, pixels: Array(repeating: UInt8($0), count: 1_000)) }
let model = GalleryModel()
await model.load(photos)
print("Thumbnails:", model.thumbnails.sorted { $0.key < $1.key })

//: Swift 6.2 approachable concurrency:
//: - With "nonisolated(nonsending) by default", a plain `nonisolated async` function runs on the CALLER's actor.
//: - So "run this off main" is now spelled `@concurrent`, not `Task.detached` or `DispatchQueue.global()`.
//: - New app targets can default to MainActor isolation; mark pure helpers `nonisolated` or `@concurrent`.
