import ComposableArchitecture

extension Reducer where State: Equatable {
    var identifiable: Reducer<IdentifiableState<State>, Action, Environment> {
        .init { state, action, environment in
            self.run(&state.state, action, environment)
        }
    }
}
