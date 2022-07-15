import ComposableArchitecture
import SwiftUI

struct CounterDetailView: View {
    let store: Store<CounterDetailState, CounterDetailAction>

    var body: some View {
        CounterView(
            store: store.scope(
                state: \.counter,
                action: CounterDetailAction.counterView
            )
        )
        .alert(store.scope(state: \.alert), dismiss: .resetAlert)
    }
}
