import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/manager/db/dp_provider.dart';
import 'package:sqflite/sqflite.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 14:06
/// @Email gstory0404@gmail.com
/// @Description: 书籍表

class BookDao extends DBProvider{

  final _tableName = "books";

  final _tableId = "id";
  final _sourceName = "source_name";
  final _sourceUrl = "source_url";
  final _bookName = "book_name";
  final _bookUrl = "book_url";
  final _cover = "cover";
  final _author = "author";
  final _updateTime = "update_time";
  final _intro = "intro";
  final _lastChapter = "last_chapter";
  final _isBookShelf = "is_bookshelf";
  final _addTime = "add_time";
  final _lastReadTime = "last_read_time";
  final _lastReadChapter = "last_read_chapter";
  final _lastReadUrl = "last_read_url";
  final _lastReadIndex = "last_read_index";

  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSql() {
    return '''
            create table $_tableName (
              $_tableId integer primary key autoincrement,
              $_sourceName TEXT,
              $_sourceUrl TEXT,
              $_bookName TEXT,
              $_bookUrl TEXT,
              $_cover TEXT,
              $_author TEXT,
              $_updateTime TEXT,
              $_intro CHAR(200),
              $_lastChapter TEXT,
              $_isBookShelf INTEGER,
              $_addTime INTEGER,
              $_lastReadTime INTEGER,
              $_lastReadChapter TEXT,
              $_lastReadUrl TEXT,
              $_lastReadIndex INTEGER
              )''';
  }

  ///插入单本数据
  Future<BookDetailBean> insert(BookDetailBean book) async {
    Database db = await getDB();
    book.id = await db.insert(tableName(), book.toJson());
    return book;
  }

  ///查询所有数据
  Future<List<BookDetailBean>> queryAll() async {
    Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return BookDetailBean.fromJson(maps[i]);
    });
  }

  ///根据url查询书籍
  Future<BookDetailBean> query(String sourceUrl, String bookUrl) async {
    Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(_tableName,
        where: "$_sourceUrl = ? and $_bookUrl = ?", whereArgs: [sourceUrl, bookUrl]);
    if (maps.isNotEmpty) {
      return BookDetailBean.fromJson(maps[0]);
    } else {
      return BookDetailBean();
    }
  }

  ///查询所有书架书籍
  Future<List<BookDetailBean>> queryAllBookShelf() async {
    Database db = await getDB();
    final List<Map<String, dynamic>> maps =
    await db.query(_tableName, where: "$_isBookShelf = ?", whereArgs: [1]);
    return List.generate(maps.length, (i) {
      return BookDetailBean.fromJson(maps[i]);
    });
  }

  ///更新书籍
  Future<BookDetailBean> update(BookDetailBean book) async {
    Database db = await getDB();
    await db.update(
      _tableName,
      book.toJson(),
      where: "$_tableId = ?",
      whereArgs: [book.id],
    );
    return book;
  }

}

