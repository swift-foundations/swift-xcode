private import XML
public import Xcode_Workspace_Standard

extension Xcode.Workspace {
    /// Serializes `contents.xcworkspacedata` through the XML foundation.
    public var xml: Swift.String {
        let root = XML.element(
            "Workspace",
            attributes: [.init(name: "version", value: version)],
            children: references.map { reference in
                XML.element(
                    "FileRef",
                    attributes: [
                        // swift-linter:disable:next raw value access
                        // REASON: serializing the location's typed value into
                        // the XML wire format at this module's own boundary.
                        .init(name: "location", value: reference.location.rawValue)
                    ]
                )
            }
        )
        return XML.Document(version: .v1_0, encoding: "UTF-8", root: root).serialize(pretty: true)
    }
}
