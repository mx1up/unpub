abstract class PackageStore {
  bool supportsDownloadUrl = false;

  String downloadUrl(String name, String version) {
    throw 'downloadUri not implemented';
  }

  Stream<List<int>> download(String name, String version) {
    throw 'download not implemented';
  }

  Future<void> upload(String name, String version, List<int> content);

  Future<bool> renameVersion(String name, String oldVersion, String newVersion);

  Future<void> deleteVersion(String name, String version);
}
