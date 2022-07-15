import ComposableArchitecture
import Foundation

// MARK: - State

struct LockState: Equatable {
    let code: [Int]
    var digits: IdentifiedArrayOf<DigitState>
    var unlocked: Bool = false

    init(code: [Int]) {
        self.code = code
        self.digits = .init(uniqueElements: (0..<code.count).map { _ in .lockDigit })
    }
}

// MARK: - Action

enum LockAction: Equatable {
    case digitView(UUID, CounterAction)
}

// MARK: - Reducer

let lockReducer: Reducer<LockState, LockAction, LockEnvironment> = .combine(
    counterReducer.identifiable.forEach(
        state: \.digits,
        action: /LockAction.digitView,
        environment: \.counter
    ),
    Reducer { state, action, _ in
        switch action {
        case let .digitView(_, .incrementComplete(.success(value))),
             let .digitView(_, .decrementComplete(.success(value))):
            state.unlocked = state.digits.map(\.value) == state.code
            return .none

        case .digitView:
            return .none
        }
    }
)

// MARK: - Environment

struct LockEnvironment {
    var counter: CounterEnvironment
}

// MARK: - Support

typealias DigitState = IdentifiableState<CounterState>

fileprivate extension DigitState {
    static var lockDigit: Self { .init(id: UUID(), state: .init(value: 0, min: 0, max: 9)) }
}



