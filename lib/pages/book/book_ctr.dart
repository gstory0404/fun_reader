import 'package:fun_novel/entity/chapter_bean.dart';
import 'package:fun_novel/entity/rule_bean.dart';
import 'package:fun_novel/manager/my_connect.dart';
import 'package:fun_novel/pages/book/book_connect.dart';
import 'package:fun_novel/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookCtr extends GetxController {
  MyConnect connect = Get.find();
  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0;
  RuleBean? rule;

  //书籍相关参数
  var bookName = "".obs;
  var cover = "".obs;
  var author = "".obs;
  var category = [].obs;
  var updateTime = "".obs;
  var intro = "".obs;
  var lastChapter = "".obs;
  List<ChapterBean> chapterList = [];

  BookCtr({this.sourceUrl = "",this.bookUrl = ""});

  @override
  void onReady() {
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    if(sourceUrl.isNotEmpty && bookUrl.isNotEmpty){
      getBookDetail();
    }
  }

  //获取书籍详情
  Future<void> getBookDetail() async {
    //解析规则
    rule = connect.spiderManager.getRule(sourceUrl);
    var html = await connect.getData(sourceUrl, bookUrl);
    bookName.value =
        XPath.html(html).query(rule?.bookInfo!.name ?? "").attr ?? "";
    cover.value =
        XPath.html(html).query(rule?.bookInfo!.cover ?? "").attr ?? "";
    author.value =
        XPath.html(html).query(rule?.bookInfo!.author ?? "").attr ?? "";
    category.value =
        XPath.html(html).query(rule?.bookInfo!.category ?? "").attrs;
    updateTime.value =
        XPath.html(html).query(rule?.bookInfo!.updateTime ?? "").attr ?? "";
    intro.value =
        XPath.html(html).query(rule?.bookInfo!.intro ?? "").attr ?? "";
    lastChapter.value =
        XPath.html(html).query(rule?.bookInfo!.intro ?? "").attr ?? "";
    //如果章节列表 规则为空则在当前页面解析 章节列表
    if (rule?.bookInfo!.chapterUrl == null) {
      var chapters =
          XPath.html(html).query(rule?.chapter?.chapterList ?? "").nodes;
      for (var element in chapters) {
        var chapterName =
            element.queryXPath(rule?.chapter?.chapterName ?? "").attr ?? "";
        var chapterUrl =
            element.queryXPath(rule?.chapter?.chapterUrl ?? "").attr ?? "";
        chapterList
            .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
      }
    } else {
      var chapterAllUrl =
          XPath.html(html).query(rule?.bookInfo!.chapterUrl ?? "").attr ?? "";
      getBookChapterList(chapterAllUrl);
    }
  }

  //获取章节列表
  Future<void> getBookChapterList(String chapterAllUrl,
      {bool isNew = false}) async {
    LogUtil.d(chapterAllUrl);
    var html = await connect.getData(sourceUrl, chapterAllUrl);
    var chapters = XPath.html(html).query(rule?.chapter?.chapterList ?? "").nodes;
    LogUtil.d( XPath.html(html).query(rule?.chapter?.chapterList ?? "").nodes);
    if (isNew) {
      chapterList.clear();
    }
    for (var element in chapters) {
      var chapterName =
          element.queryXPath(rule!.chapter!.chapterName!).attr ?? "";
      var chapterUrl = element.queryXPath(rule!.chapter!.chapterUrl!).attr;
      chapterList
          .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
    }
    //如果存在下一页 就继续加载
    if (rule?.chapter?.nextPage == null) {
      var nextPage = XPath.html(html).query(rule!.chapter!.nextPage!).attr;
      if (nextPage != null) {
        getBookChapterList(nextPage);
      }
    }
    LogUtil.d(chapterList);
  }
}
