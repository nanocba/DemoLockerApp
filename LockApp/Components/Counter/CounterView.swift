import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    let store: Store<CounterState, CounterAction>

    var body: some View {
        WithViewStore(store.scope(state: \.view, action: CounterAction.view)) { viewStore in
            HStack {
                Button("-", action: { viewStore.send(.decrement) })

                Text(viewStore.counter)

                Button("+", action: { viewStore.send(.increment) })
            }
        }
    }
}

extension CounterView {
    struct ViewState: Equatable {
        let counter: String
    }

    enum ViewAction: Equatable {
        case increment
        case decrement
    }
}

extension CounterState {
    var view: CounterView.ViewState {
        .init(counter: "\(value)")
    }
}

extension CounterAction {
    static func view(_ localAction: CounterView.ViewAction) -> Self {
        switch localAction {
        case .increment:
            return .increment
        case .decrement:
            return .decrement
        }
    }
}

#if DEBUG
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: .dummy(
                state: .init(
                    value: 5, min: 0, max: 9
                )
            )
        )
    }
}
#endif
