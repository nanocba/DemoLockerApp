import ComposableArchitecture

// MARK: - State

struct CounterDetailState: Equatable {
    var counter: CounterState
    var alert: AlertState<CounterDetailAction>?

    init(value: Int) {
        counter = .init(value: value, min: -10, max: 10)
    }
}

// MARK: - Action

enum CounterDetailAction: Equatable {
    case counterView(CounterAction)
    case resetAlert
    case didSetValue(Int)
}

// MARK: - Reducer

let counterDetailReducer: Reducer<CounterDetailState, CounterDetailAction, CounterDetailEnvironment> = .combine(
    counterReducer.pullback(
        state: \.counter,
        action: /CounterDetailAction.counterView,
        environment: \.counter
    ),
    Reducer { state, action, _ in
        switch action {
        case .resetAlert:
            state.alert = nil
            return .none

        case .counterView(.incrementComplete(.failure(.maxBoundReached))):
            state.setAlert(msg: "Can't go beyond \(state.counter.max)")
            return .none

        case .counterView(.decrementComplete(.failure(.minBoundReached))):
            state.setAlert(msg: "Can't go lower \(state.counter.min)")
            return .none

        case let .counterView(.incrementComplete(.success(value))),
             let .counterView(.decrementComplete(.success(value))):
            return Effect(value: .didSetValue(value))

        case .counterView,
             .didSetValue:
            return .none
        }
    }
)

// MARK: - Environment

struct CounterDetailEnvironment {
    var counter: CounterEnvironment
}

// MARK: - Helpers

extension CounterDetailState {
    mutating func setAlert(msg: String) {
        alert = .init(title: .init(msg))
    }
}


