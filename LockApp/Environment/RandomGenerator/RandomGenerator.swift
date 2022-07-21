import ComposableArchitecture
import Foundation

struct RandomGenerator {
    struct Interface {
        var generateInts: GenerateInts
    }

    typealias GenerateInts = () -> Effect<Int, Never>
}
