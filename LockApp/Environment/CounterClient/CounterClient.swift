import ComposableArchitecture
import Foundation

struct CounterClient {
    struct Interface {
        var increment: Increment
        var decrement: Decrement
    }

    typealias Increment = (_ value: Int, _ max: Int) -> Effect<Int, IncrementError>
    typealias Decrement = (_ value: Int, _ min: Int) -> Effect<Int, DecrementError>

    enum IncrementError: Swift.Error, Equatable {
        case maxBoundReached
    }

    enum DecrementError: Swift.Error, Equatable {
        case minBoundReached
    }
}
