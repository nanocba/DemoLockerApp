import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        NavigationView {
            RootView(
                store: store.scope(
                    state: \.root,
                    action: AppAction.rootView
                )
            )
        }
        .navigationViewStyle(.stack)
    }
}
