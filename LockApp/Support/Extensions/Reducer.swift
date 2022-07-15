import ComposableArchitecture

extension Reducer where State: Equatable {
    /// This method allows to transform any reducer into one that works with an ``IdentifiableState``.
    func identifiable<ID: Hashable>() -> Reducer<IdentifiableState<ID, State>, Action, Environment> {
        .init { state, action, environment in
            self.run(&state.state, action, environment)
        }
    }
}
