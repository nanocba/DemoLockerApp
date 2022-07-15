import ComposableArchitecture

extension Reducer where State: Equatable {
    func identifiable<ID: Hashable>() -> Reducer<IdentifiableState<ID, State>, Action, Environment> {
        .init { state, action, environment in
            self.run(&state.state, action, environment)
        }
    }
}
