import ComposableArchitecture
import OrderedCollections
import SwiftUI

extension ForEachStore {
    init<State, EachContent>(
        _ store: Store<IdentifiedArray<ID, EachState>, (ID, EachAction)>,
        @ViewBuilder content: @escaping (Store<State, EachAction>) -> EachContent
    )
    where
        State: Equatable,
        EachState == IdentifiableState<State>,
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
