import 'package:fun_reader/entity/chapter_bean.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 18:13
/// @Email gstory0404@gmail.com
/// @Description: 书籍详情

class BookDetailBean{
  var bookName = "";
  var cover = "";
  var author = "";
  var category = [];
  var updateTime = "";
  var intro = "";
  var lastChapter = "";
  List<ChapterBean> chapterList = [];

  BookDetailBean();
}


