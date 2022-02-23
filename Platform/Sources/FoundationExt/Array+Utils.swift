import Foundation

public extension Array {
    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

