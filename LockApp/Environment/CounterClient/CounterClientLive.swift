import ComposableArchitecture
import Foundation

extension CounterClient.Interface {
    static var live: Self {
        .init(
            increment: { value, max in
                let newValue = value + 1
                return newValue <= max
                  ? Effect(value: newValue)
                  : Effect(error: .maxBoundReached)
            },
            decrement: { value, min in
                let newValue = value - 1
                return newValue >= min
                    ? Effect(value: newValue)
                    : Effect(error: .minBoundReached)
            }
        )
    }
}
