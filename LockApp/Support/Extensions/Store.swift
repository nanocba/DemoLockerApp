import ComposableArchitecture

extension Store {
    static func dummy(state: State) -> Self {
        .init(
            initialState: state,
            reducer: .empty,
            environment: ()
        )
    }
}
