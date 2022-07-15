import ComposableArchitecture

// MARK: - State

struct CounterState: Equatable {
    var value: Int
    var min: Int
    var max: Int
}

// MARK: - Action

enum CounterAction: Equatable {
    case incrementComplete(Result<Int, CounterClient.IncrementError>)
    case decrementComplete(Result<Int, CounterClient.DecrementError>)

    case increment
    case decrement
}

// MARK: - Reducer

let counterReducer = Reducer<CounterState, CounterAction, CounterEnvironment> { state, action, environment in
    switch action {
    case .increment:
        return environment.increment(state.value, state.max)
            .catchToEffect(CounterAction.incrementComplete)

    case .decrement:
        return environment.decrement(state.value, state.min)
            .catchToEffect(CounterAction.decrementComplete)

    case let .incrementComplete(.success(value)),
         let .decrementComplete(.success(value)):
        state.value = value
        return .none

    case .incrementComplete(.failure),
         .decrementComplete(.failure):
        return .none
    }
}

// MARK: - Environment

struct CounterEnvironment {
    var increment: CounterClient.Increment
    var decrement: CounterClient.Decrement
}
