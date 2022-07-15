import ComposableArchitecture

extension Store {
    /// This method allows to create a dummy store with a reducer that does nothing and void environment. Useful for static previews to be able to create a fake store by only specifying its initial state.
    static func dummy(state: State) -> Self {
        .init(
            initialState: state,
            reducer: .empty,
            environment: ()
        )
    }
}
