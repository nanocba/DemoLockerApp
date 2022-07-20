import Combine
import Foundation

extension AppEnvironment {
    init() {
        self.counterClient = .live
        self.randomGenerator = .live
    }
}
