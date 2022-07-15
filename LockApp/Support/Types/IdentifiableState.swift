import Foundation

/// The ``IdentifiableState`` type wraps a ``State`` adding ``Identifiable`` conformance. This is useful when the base type may not always need to satisfy this requirement.
/// By adding ``@dynamicMemberLookup`` attribute we are letting developers access wrapped state properties directly.
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
