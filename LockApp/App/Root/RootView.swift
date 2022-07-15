import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: Store<RootState, RootAction>

    var body: some View {
        WithViewStore(store.scope(state: \.view, action: RootAction.view)) { viewStore in
            VStack {
                Text(viewStore.counter)

                NavigationLink(
                    "Go to Detail",
                    isActive: viewStore.binding(
                        get: \.counterDetailActive,
                        send: ViewAction.setCounterDetailActive
                    ),
                    destination: {
                        IfLetStore(
                            store.scope(
                                state: \.counterDetail,
                                action: RootAction.counterDetailView),
                            then: CounterDetailView.init
                        )
                    }
                )
                .padding(.top, 50)

                Button("Go to Lock", action: { viewStore.send(.setLockActive(true)) })
                    .padding(.top, 50)
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.lockActive,
                    send: ViewAction.setLockActive)
            ) {
                IfLetStore(
                    store.scope(
                        state: \.lock,
                        action: RootAction.lockView),
                    then: LockView.init
                )
            }

        }
    }
}

extension RootView {
    struct ViewState: Equatable {
        let counter: String
        let counterDetailActive: Bool
        let lockActive: Bool
    }

    enum ViewAction: Equatable {
        case setCounterDetailActive(Bool)
        case setLockActive(Bool)
    }
}

extension RootState {
    var view: RootView.ViewState {
        .init(
            counter: "\(counter)",
            counterDetailActive: counterDetail != nil,
            lockActive: lock != nil
        )
    }
}

extension RootAction {
    static func view(_ localAction: RootView.ViewAction) -> RootAction {
        switch localAction {
        case .setCounterDetailActive(true):
            return .activateCounterDetail
        case .setCounterDetailActive(false):
            return .resetCounterDetail
        case .setLockActive(true):
            return .activateLock
        case .setLockActive(false):
            return .resetLock
        }
    }
}
