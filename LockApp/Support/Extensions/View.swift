import SwiftUI

extension View {
    @ViewBuilder
    func hidden(`if` condition: Bool) -> some View {
        if condition {
            self.hidden()
        } else {
            self
        }
    }
}
