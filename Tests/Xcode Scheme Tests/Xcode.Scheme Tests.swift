import Testing
import Xcode_Scheme

@Test
func `scheme serialization contains typed build and test entries`() {
    let reference = Xcode.Scheme.Reference(
        blueprint: "Workspace-Package",
        name: "Workspace-Package",
        container: "container:Application"
    )
    let scheme = Xcode.Scheme(
        build: [.init(reference: reference)],
        test: [.init(reference: reference)]
    )
    #expect(scheme.xml.contains("BuildActionEntry"))
    #expect(scheme.xml.contains("TestableReference"))
}
