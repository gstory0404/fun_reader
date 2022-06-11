import 'package:fun_novel/entity/chapter_bean.dart';
import 'package:fun_novel/pages/book/book_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookCtr extends GetxController {
  BookConnect connect;
  var bookId = "";
  //书籍相关参数
  var bookName = "".obs;
  var logo = "".obs;
  var author = "".obs;
  var category = "".obs;
  var status = "".obs;
  var updateTime = "".obs;
  var content = "".obs;
  var lastChapter = "".obs;
  var readId = "";
  var allChapterUrl = "";
  List<ChapterBean> chapterList = [];

  BookCtr({required this.connect});

  @override
  void onReady() {
    bookId = Get.arguments['bookId'];
    getBookDetail(bookId);
  }

  Future<void> getBookDetail(String id) async {
    var html = await connect.getBookDetail(id);

    bookName.value = XPath.html(html)
            .query(connect.spiderManager.spiderBean!.book!.bookName!)
            .attr
            ?.replaceAll(" ", "")
            .replaceAll("\n", "")
            .replaceAll("\r;", "") ??
        "";
    logo.value = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.book!.logo!)
        .attr ?? "";
    author.value = XPath.html(html)
            .query(connect.spiderManager.spiderBean!.book!.author!)
            .attr
            ?.replaceAll(" ", "")
            .replaceAll("\n", "")
            .replaceAll("\r;", "") ??
        "";
    category.value = XPath.html(html)
            .query(connect.spiderManager.spiderBean!.book!.category!)
            .attr
            ?.replaceAll(" ", "")
            .replaceAll("\n", "")
            .replaceAll("\r;", "") ??
        "";
    status.value = XPath.html(html)
            .query(connect.spiderManager.spiderBean!.book!.status!)
            .attr
            ?.replaceAll(" ", "")
            .replaceAll("\n", "")
            .replaceAll("\r;", "") ??
        "";
    updateTime.value = XPath.html(html)
            .query(connect.spiderManager.spiderBean!.book!.updateTime!)
            .attr
            ?.replaceAll(" ", "")
            .replaceAll("\n", "")
            .replaceAll("\r;", "") ??
        "";
    content.value = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.book!.content!)
        .attr
        ?.replaceAll(" ", "")
        .replaceAll("\n", "")
        .replaceAll("\r;", "") ??
        "";
    lastChapter.value = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.book!.lastChapter!)
        .attr
        ?.replaceAll(" ", "")
        .replaceAll("\n", "")
        .replaceAll("\r;", "") ??
        "";
    readId =  XPath.html(html)
        .query(connect.spiderManager.spiderBean!.book!.readId!)
        .attr ?? "";
    allChapterUrl =  XPath.html(html)
        .query(connect.spiderManager.spiderBean!.book!.allChapterUrl!)
        .attr ?? "";
    print("$readId====$allChapterUrl");
    getBookChapterList(allChapterUrl);
  }

  //获取章节列表
  Future<List<ChapterBean>> getBookChapterList(String path) async {
    if(chapterList.isNotEmpty){
      return chapterList;
    }
    var html = await connect.getBookChapterList(path);
    var chapters =  XPath.html(html)
        .query(connect.spiderManager.spiderBean!.chapter!.chapters!)
        .nodes;
    chapterList.clear();
    for (var element in chapters) {
      var name = element
          .queryXPath(connect.spiderManager.spiderBean!.chapter!.name!)
          .attr?.replaceAll(" ", "")
          .replaceAll("\n", "")
          .replaceAll("\r;", "") ??
          "";
      var id = element
          .queryXPath(connect.spiderManager.spiderBean!.chapter!.id!)
          .attr;
      chapterList.add(ChapterBean(name: name,id: id));
    }
    return chapterList;
  }
}
