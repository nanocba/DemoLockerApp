import ComposableArchitecture

// MARK: - State

struct AppState: Equatable {
    var root: RootState = .init()
}

// MARK: - Action

enum AppAction: Equatable {
    case rootView(RootAction)
}

// MARK: - Reducer

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    rootReducer.pullback(
        state: \.root,
        action: /AppAction.rootView,
        environment: \.root
    )
)

// MARK: - Environment

struct AppEnvironment {
    var counterClient: CounterClient.Interface
    var randomGenerator: RandomGenerator.Interface
}

// MARK: - Children environment derivations

extension AppEnvironment {
    var root: RootEnvironment {
        .init(
            counter: .init(
                increment: counterClient.increment,
                decrement: counterClient.decrement),
            randomInts: randomGenerator.generateInts
        )
    }
}


