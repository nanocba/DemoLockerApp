import Foundation

@dynamicMemberLookup
struct IdentifiableState<ID: Hashable, State: Equatable>: Equatable, Identifiable {
    let id: ID
    var state: State

    subscript<StateProperty>(dynamicMember keyPath: KeyPath<State, StateProperty>) -> StateProperty {
        self.state[keyPath: keyPath]
    }

    subscript<StateProperty>(dynamicMember keyPath: WritableKeyPath<State, StateProperty>) -> StateProperty {
        get { self.state[keyPath: keyPath] }
        set { self.state[keyPath: keyPath] = newValue }
    }
}
