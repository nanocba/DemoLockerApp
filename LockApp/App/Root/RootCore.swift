import ComposableArchitecture

// MARK: - State

struct RootState: Equatable {
    var counter: Int = 0
    var counterDetail: CounterDetailState?
    var lock: LockState?
}

// MARK: - Action

enum RootAction: Equatable {
    case counterDetailView(CounterDetailAction)
    case lockView(LockAction)
    case activateCounterDetail
    case resetCounterDetail
    case activateLock
    case resetLock
}

// MARK: - Reducer

let rootReducer: Reducer<RootState, RootAction, RootEnvironment> = .combine(
    counterDetailReducer.optional().pullback(
        state: \.counterDetail,
        action: /RootAction.counterDetailView,
        environment: \.counterDetail
    ),
    lockReducer.optional().pullback(
        state: \.lock,
        action: /RootAction.lockView,
        environment: \.lock
    ),
    Reducer { state, action, _ in
        switch action {
        case .activateCounterDetail:
            state.counterDetail = .init(value: state.counter)
            return .none

        case .resetCounterDetail:
            state.counterDetail = nil
            return .none

        case .activateLock:
            state.lock = .init(code: [9, 5, 7])
            return .none

        case .resetLock:
            state.lock = nil
            return .none

        case .counterDetailView(.didSetValue(let value)):
            state.counter = value
            return .none

        case .counterDetailView,
             .lockView:
            return .none
        }
    }
)

// MARK: - Environment

struct RootEnvironment {
    var counter: CounterEnvironment
}

// MARK: - Children environment derivations

extension RootEnvironment {
    var counterDetail: CounterDetailEnvironment {
        .init(counter: counter)
    }

    var lock: LockEnvironment {
        .init(counter: counter)
    }
}
