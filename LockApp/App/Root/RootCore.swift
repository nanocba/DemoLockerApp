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
    case onAppear
    case setRandomCounter(Int)
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
    Reducer { state, action, environment in
        switch action {
        case .onAppear:
            return environment.randomInts()
                .map(RootAction.setRandomCounter)

        case .setRandomCounter(let value):
            state.counter = value
            return .none

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
    var randomInts: RandomGenerator.GenerateInts
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
