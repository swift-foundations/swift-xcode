import Testing
import Xcode_Workspace

@Test
func `workspace serialization uses XML escaping`() {
    let workspace = Xcode.Workspace(references: [
        .init(location: .group("Packages/a&b"))
    ])
    #expect(workspace.xml.contains("location=\"group:Packages/a&amp;b\""))
}
