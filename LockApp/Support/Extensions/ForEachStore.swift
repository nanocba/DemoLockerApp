import ComposableArchitecture
import OrderedCollections
import SwiftUI

extension ForEachStore {
    /// This initializer offers a specialized signature when ``EachState`` is ``IdentifiableState`` type, allowing to pass over a closure that takes a
    /// store of the ``IdentifiableState.State`` instead of the identifiable state per se removing the need to `scope` down in the views.
    init<State, EachContent>(
        _ store: Store<IdentifiedArray<ID, EachState>, (ID, EachAction)>,
        @ViewBuilder content: @escaping (Store<State, EachAction>) -> EachContent
    )
    where
        State: Equatable,
        EachState == IdentifiableState<ID, State>,
        EachContent: View,
        Data == IdentifiedArray<ID, EachState>,
        Content == WithViewStore<
            OrderedSet<ID>, (ID, EachAction), ForEach<OrderedSet<ID>, ID, EachContent>
        > {
            self.init(store, transform: { $0.scope(state: \.state)}, content: content)
    }

    private init<State, EachContent>(
        _ store: Store<IdentifiedArray<ID, EachState>, (ID, EachAction)>,
        transform: @escaping (Store<EachState, EachAction>) -> Store<State, EachAction>,
        @ViewBuilder content: @escaping (Store<State, EachAction>) -> EachContent
    )
    where
        State: Equatable,
        EachContent: View,
        Data == IdentifiedArray<ID, EachState>,
        Content == WithViewStore<
            OrderedSet<ID>, (ID, EachAction), ForEach<OrderedSet<ID>, ID, EachContent>
        > {
            self.init(store) { content(transform($0)) }
    }
}
