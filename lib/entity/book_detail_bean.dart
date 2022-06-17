import 'package:fun_reader/entity/chapter_bean.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 18:13
/// @Email gstory0404@gmail.com
/// @Description: 书籍详情

class BookDetailBean{
  int? id;
  String? sourceName;
  String? sourceUrl;
  String? bookUrl;
  String? bookName;
  String? cover;
  String? author;
  String? updateTime;
  String? intro;
  String? lastChapter;
  int addTime = 0;
  int lastReadTime = 0;
  String? lastReadChapter;
  String? lastReadUrl;
  int lastReadIndex = 0;
  bool isBookshelf = false;
  List<ChapterBean> chapterList = [];
  List<String?> category =[];

  BookDetailBean({
    id,
    sourceName,
    sourceUrl,
    bookUrl,
    bookName,
    cover,
    author,
    updateTime,
    intro,
    lastChapter,
    isBookshelf,
    addTime,
    lastReadTime,
    lastReadChapter,
    lastReadUrl,
    lastReadIndex,
  });

  BookDetailBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceName = json['source_name'];
    sourceUrl = json['source_url'];
    bookUrl = json['book_url'];
    bookName = json['book_name'];
    cover = json['cover'];
    author = json['author'];
    updateTime = json['update_time'];
    intro = json['intro'];
    lastChapter = json['last_chapter'];
    isBookshelf = json['is_bookshelf'] == 1;
    addTime = json['add_time'];
    lastReadTime = json['last_read_time'];
    lastReadChapter = json['last_read_chapter'];
    lastReadUrl = json['last_read_url'];
    lastReadIndex = json['last_read_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['source_name'] = sourceName;
    data['source_url'] = sourceUrl;
    data['book_url'] = bookUrl;
    data['book_name'] = bookName;
    data['cover'] = cover;
    data['author'] = author;
    data['update_time'] = updateTime;
    data['intro'] = intro;
    data['last_chapter'] = lastChapter;
    data['is_bookshelf'] = isBookshelf ? 1 : 0;
    data['add_time'] = addTime;
    data['last_read_time'] = lastReadTime;
    data['last_read_chapter'] = lastReadChapter;
    data['last_read_url'] = lastReadUrl;
    data['last_read_index'] = lastReadIndex;
    return data;
  }
}


