private import File_System
public import Xcode_Workspace_Standard

extension Xcode.Workspace {

    public func write(to directory: Swift.String) throws(Error) {
        let bundle: File.Path
        do throws(File.Path.Error) {
            bundle = try File.Path(directory)
        } catch {
            throw .path
        }
        do throws(File.System.Create.Directory.Error) {
            try File.System.Create.Directory.create(at: bundle, createIntermediates: true)
        } catch {
            throw .create
        }
        do throws(File.System.Write.Atomic.Error) {
            try File(bundle / "contents.xcworkspacedata").write.atomic(xml)
        } catch {
            throw .write
        }
    }
}
