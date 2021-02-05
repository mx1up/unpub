import 'dart:io';
import 'package:path/path.dart' as path;
import 'package_store.dart';

class FileStore extends PackageStore {
  String baseDir;

  FileStore(this.baseDir);

  File _getTarballFile(String package, String version) {
    return File(path.join(baseDir, '$package-$version.tar.gz'));
  }

  @override
  Future<void> upload(String package, String version, List<int> content) async {
    var file = _getTarballFile(package, version);
    await file.create(recursive: true);
    await file.writeAsBytes(content);
  }

  @override
  Stream<List<int>> download(String package, String version) {
    return _getTarballFile(package, version).openRead();
  }

  @override
  Future<bool> renameVersion(String name, String oldVersion, String newVersion) async {
    var oldFile = _getTarballFile(name, oldVersion);
    var newFile = await oldFile.rename(_getTarballFile(name, newVersion).path);
    return newFile.path == _getTarballFile(name, newVersion).path;
  }
}
