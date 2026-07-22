public import Xcode_Workspace_Standard

extension Xcode.Workspace {
    public enum Error: Swift.Error, Sendable, Equatable {
        case path
        case create
        case write
    }
}
