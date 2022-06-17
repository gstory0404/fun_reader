import 'dart:io';

import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/17 09:40
/// @Email gstory0404@gmail.com
/// @Description: 数据库管理类

class DBManager {
  var bookTable = 'books';
  late Database db;

  DBManager._internal();

  factory DBManager() => _instance;

  static final DBManager _instance = DBManager._internal();

  Future<void> init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'fun_novel.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE $bookTable(id INTEGER PRIMARY KEY,"
              "source_name TEXT,"
              "source_url TEXT,"
              "book_name TEXT,"
              "book_url TEXT,"
              "cover TEXT,"
              "author TEXT,"
              "update_time TEXT,"
              "intro CHAR(200),"
              "last_chapter TEXT,"
              "is_bookshelf INTEGER,"
              "add_time INTEGER,"
              "last_read_time INTEGER,"
              "last_read_chapter TEXT,"
              "last_read_url TEXT,"
              "last_read_index INTEGER)");
        },
      );
    } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      var factory = databaseFactoryFfi;
      db = await factory.openDatabase(
        inMemoryDatabasePath,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              await db.execute("CREATE TABLE $bookTable(id INTEGER PRIMARY KEY,"
                  "source_name TEXT,"
                  "source_url TEXT,"
                  "book_name TEXT,"
                  "book_url TEXT,"
                  "cover TEXT,"
                  "author TEXT,"
                  "update_time TEXT,"
                  "intro CHAR(200),"
                  "last_chapter TEXT,"
                  "is_bookshelf INTEGER,"
                  "add_time INTEGER,"
                  "last_read_time INTEGER,"
                  "last_read_chapter TEXT,"
                  "last_read_url TEXT,"
                  "last_read_index INTEGER)");
            }),
      );
    }
  }

  //插入单本数据
  Future<BookDetailBean> insertBook(BookDetailBean book) async {
    book.id =  await db.insert(bookTable, book.toJson());
    return book;
  }

  //查询所有数据
  Future<List<BookDetailBean>> queryAllBooks() async {
    final List<Map<String, dynamic>> maps = await db.query(bookTable);
    return List.generate(maps.length, (i) {
      return BookDetailBean.fromJson(maps[i]);
    });
  }

  //根绝url查询书籍
  Future<BookDetailBean> queryBook(String sourceUrl, String bookUrl) async {
    final List<Map<String, dynamic>> maps = await db.query(bookTable,
        where: "source_url=? and book_url=?", whereArgs: [sourceUrl, bookUrl]);
    if (maps.isNotEmpty) {
      return BookDetailBean.fromJson(maps[0]);
    } else {
      return BookDetailBean();
    }
  }

  //更新书籍
  Future<BookDetailBean> updateBook(BookDetailBean book) async {
   await db.update(
      bookTable,
      book.toJson(),
      where: "id = ?",
      whereArgs: [book.id],
    );
    return book;
  }
}
