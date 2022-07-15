import ComposableArchitecture
import SwiftUI

struct LockView: View {
    let store: Store<LockState, LockAction>

    var body: some View {
        WithViewStore(store.scope(state: \.view).actionless) { viewStore in
            VStack {
                ForEachStore(store.scope(state: \.digits, action: LockAction.digitView)) {
                    CounterView(store: $0.scope(state: \.state))
                }

                Text("Unlocked!")
                    .hidden(if: viewStore.unlockMessageHidden)
            }
        }
    }
}

extension LockView {
    struct ViewState: Equatable {
        let unlockMessageHidden: Bool
    }
}

extension LockState {
    var view: LockView.ViewState {
        .init(
            unlockMessageHidden: !unlocked
        )
    }
}
