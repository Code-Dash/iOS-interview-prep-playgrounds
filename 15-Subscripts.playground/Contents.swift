//: Playground Practice — Subscripts
//: Rapid Sheet: "What are subscripts in Swift? When would you use them?"
//: Run this, then practice explaining subscript syntax and use cases.

import Foundation

// MARK: - Custom subscript on a struct
struct Matrix {
    private var grid: [[Int]]

    init(rows: Int, cols: Int) {
        grid = Array(repeating: Array(repeating: 0, count: cols), count: rows)
    }

    subscript(row: Int, col: Int) -> Int {
        get { grid[row][col] }
        set { grid[row][col] = newValue }
    }
}

var matrix = Matrix(rows: 2, cols: 3)
matrix[0, 1] = 42
print("Subscript: matrix[0,1] = \(matrix[0, 1])")

// MARK: - Read-only subscript
struct SafeArray<T> {
    private var items: [T]

    init(_ items: [T]) {
        self.items = items
    }

    subscript(index: Int) -> T? {
        guard index >= 0, index < items.count else { return nil }
        return items[index]
    }
}

let safe = SafeArray([1, 2, 3])
print("Safe subscript: \(String(describing: safe[1])), \(String(describing: safe[10]))")
