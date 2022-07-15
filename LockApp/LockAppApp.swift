import ComposableArchitecture
import SwiftUI

@main
struct LockAppApp: App {
    let store = Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment())

    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
