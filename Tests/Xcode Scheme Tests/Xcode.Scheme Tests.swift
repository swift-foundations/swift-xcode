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

@Test
func `no launch action is emitted, because xcodebuild segfaults on the stub`() {
    // `Xcode.Scheme` models a build list and a test list; it cannot describe
    // anything runnable, so a `LaunchAction` could only be a content-free stub.
    // `xcodebuild -workspace … -scheme … build` dies of SIGSEGV (exit 139, no
    // diagnostic) on a scheme carrying that stub, after resolving the package
    // graph. Bisected on Xcode 27.0 (27A5228h) against a one-package
    // workspace: RC=0 with this element removed, 139 with it restored, and
    // every other action harmless in the same test.
    //
    // This asserts an absence, so it needs its own positive control: the
    // elements that *are* expected must be present, or a serializer that
    // emitted nothing at all would pass.
    let reference = Xcode.Scheme.Reference(
        blueprint: "Workspace-Package",
        name: "Workspace-Package",
        container: "container:Application"
    )
    let xml = Xcode.Scheme(
        build: [.init(reference: reference)],
        test: [.init(reference: reference)]
    ).xml

    #expect(!xml.contains("LaunchAction"))
    #expect(xml.contains("BuildAction"))
    #expect(xml.contains("TestAction"))
    #expect(xml.contains("ProfileAction"))
    #expect(xml.contains("AnalyzeAction"))
    #expect(xml.contains("ArchiveAction"))
}
