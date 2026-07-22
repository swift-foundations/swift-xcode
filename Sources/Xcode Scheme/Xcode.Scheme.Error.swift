public import Xcode_Scheme_Standard

extension Xcode.Scheme {
    public enum Error: Swift.Error, Sendable, Equatable {
        case path
        case create
        case write
    }
}
