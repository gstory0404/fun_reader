import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 12:28
/// @Email gstory0404@gmail.com
/// @Description: sqlite管理类

class DBManager {

  ///数据库版本
  static const int _dbVersion = 1;

  ///数据库名称
  static const String _dbName = "fun_novel.db";

  ///实例
  static Database? _db;

  static Future<void> _init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      _db = await openDatabase(join(await getDatabasesPath(), _dbName),
          version: _dbVersion, onCreate: (db, version) async {});
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      var factory = databaseFactoryFfi;
      _db = await factory.openDatabase(
        inMemoryDatabasePath,
        options:
            OpenDatabaseOptions(version: _dbVersion, onCreate: (db, version) async {}),
      );
    }
  }

  ///判断是否存在表
  static isTableExits(String tableName) async {
    await getDatabase();
    var res = await _db?.query("sqlite_master",where: "name = ?",whereArgs: [tableName]);
    return res != null && res.isNotEmpty;
  }

  ///获取当前db
  static Future<Database> getDatabase() async {
    if (_db == null) {
      await _init();
    }
    return _db!;
  }

  ///释放db
  static close() {
    _db?.close();
    _db = null;
  }
}
