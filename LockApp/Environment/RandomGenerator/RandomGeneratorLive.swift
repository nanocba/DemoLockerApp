import ComposableArchitecture

extension RandomGenerator.Interface {
    static var live: Self {
        .init(
            generateInts: {
                Effect.timer(
                    id: TimerId(),
                    every: 5,
                    on: DispatchQueue.main.eraseToAnyScheduler()
                )
                .map { _ in
                    Int.random(in: 0...1000)
                }
                .eraseToEffect()
            }
        )
    }

    struct TimerId: Hashable {}
}
