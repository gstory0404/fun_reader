import 'dart:convert';

import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/chapter_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MyConnect extends GetConnect {

  @override
  void onInit() {}

  //get请求
  Future<String> getData(String sourceUrl, String path,
      {Map<String, dynamic>? query}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    httpClient.timeout = const Duration(seconds: 60);
    Map<String, String>? head;
    DBRuleBean? dbRuleBean = await RuleDao().query(sourceUrl);
    if (dbRuleBean?.ruleBean?.head?.isNotEmpty ?? false) {
      head = json.decode(dbRuleBean!.ruleBean!.head!);
    }
    //添加User-Agent
    if(head?["User-Agent"] == null){
      await FlutterUserAgent.init();
      var webAgent = FlutterUserAgent.webViewUserAgent;
      head ??= {};
      head["User-Agent"] = webAgent ?? "";
    }
    Response<String> response = await get(path, query: query, headers: head);
    return response.body ?? "";
  }

  //post请求
  Future<String> postData(
      String sourceUrl, String path, Map<String, dynamic>? body,
      {String? contentType}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    Map<String, String>? head = {};
    DBRuleBean? dbRuleBean = await RuleDao().query(sourceUrl);
    if (dbRuleBean?.ruleBean?.head?.isNotEmpty ?? false) {
      head = json.decode(dbRuleBean!.ruleBean!.head!);
    }
    Response<String> response =
        await post(path, body, headers: head, contentType: contentType);
    return response.body ?? "";
  }

  ///获取分类书籍列表
  Future<List<BookBean>> getCategoryBooks(DBRuleBean rule, String path) async {
    List<BookBean> bookList = [];
    var html = await getData(rule.sourceUrl ?? "", path);
    var books = XPath.html(html).query(rule.ruleBean!.recommendBooks!.books!).nodes;
    print(path);
    print(books);
    //书籍
    for (var element in books) {
      var bookUrl = element.queryXPath(rule.ruleBean!.recommendBooks!.bookUrl!).attr;
      var name = element.queryXPath(rule.ruleBean!.recommendBooks!.name!).attr;
      var author = element.queryXPath(rule.ruleBean!.recommendBooks!.author!).attr;
      var intro = element.queryXPath(rule.ruleBean!.recommendBooks!.intro!).attr;
      var cover = element.queryXPath(rule.ruleBean!.recommendBooks!.cover!).attr;
      var category = element.queryXPath(rule.ruleBean!.recommendBooks!.category!).attrs;
      var lastChapter =
          element.queryXPath(rule.ruleBean!.recommendBooks!.lastChapter!).attr;
      bookList.add(BookBean(
          bookUrl: bookUrl,
          name: name ?? "",
          author: author ?? "",
          intro: intro ?? "",
          cover: cover ?? "",
          category: category,
          lastChapter: lastChapter ?? ""));
    }
    return bookList;
  }

  ///搜索小说
  Future<List<BookBean>> getSearchBook(RuleBean rule, String key) async {
    List<BookBean> bookList = [];
    var body = rule.search!.body!;
    body = body.replaceAll("&key&", key);
    var map = json.decode(body);
    String html;
    if (rule.search?.method == "POST") {
      html = await postData(rule.sourceUrl!, rule.search!.url!, map,
          contentType: rule.search!.contentType);
    } else {
      html = await getData(rule.sourceUrl!, rule.search!.url!, query: map);
    }
    var books = XPath.html(html).query(rule.searchBooks!.books!).nodes;
    print("$books");
    //书籍
    for (var element in books) {
      var bookUrl = element.queryXPath(rule.searchBooks!.bookUrl!).attr;
      var name = element.queryXPath(rule.searchBooks!.name!).attr;
      var author = element.queryXPath(rule.searchBooks!.author!).attr;
      var intro = element.queryXPath(rule.searchBooks!.intro!).attr;
      var cover = element.queryXPath(rule.searchBooks!.cover!).attr;
      var category = element.queryXPath(rule.searchBooks!.category!).attrs;
      var lastChapter = element.queryXPath(rule.searchBooks!.lastChapter!).attr;
      bookList.add(BookBean(
          bookUrl: bookUrl,
          name: name ?? "",
          author: author ?? "",
          intro: intro ?? "",
          cover: cover ?? "",
          category: category,
          lastChapter: lastChapter ?? ""));
    }
    return bookList;
  }

  ///获取书籍详情
  Future<BookDetailBean> getBookDetail(RuleBean rule, String bookUrl) async {
    var book = await BookDao().query(rule.sourceUrl ?? "", bookUrl);
    if(book.id == null){
      book.sourceName = rule.sourceName;
      book.sourceUrl = rule.sourceUrl;
      book.bookUrl = bookUrl;
    }
    var html = await getData(rule.sourceUrl ?? "", bookUrl);
    book.bookName =
        XPath.html(html).query(rule.bookInfo!.name ?? "").attr ?? "";
    book.cover = XPath.html(html).query(rule.bookInfo!.cover ?? "").attr ?? "";
    book.author =
        XPath.html(html).query(rule.bookInfo!.author ?? "").attr ?? "";
    book.category = XPath.html(html).query(rule.bookInfo!.category ?? "").attrs;
    book.updateTime =
        XPath.html(html).query(rule.bookInfo!.updateTime ?? "").attr ?? "";
    book.intro = XPath.html(html).query(rule.bookInfo!.intro ?? "").attr ?? "";
    book.lastChapter =
        XPath.html(html).query(rule.bookInfo!.intro ?? "").attr ?? "";
    //如果章节列表 规则为空则在当前页面解析 章节列表
    if (rule.bookInfo!.chapterUrl == null) {
      var chapters =
          XPath.html(html).query(rule.chapter?.chapterList ?? "").nodes;
      for (var element in chapters) {
        var chapterName =
            element.queryXPath(rule.chapter?.chapterName ?? "").attr ?? "";
        var chapterUrl =
            element.queryXPath(rule.chapter?.chapterUrl ?? "").attr ?? "";
        book.chapterList
            .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
      }
    } else {
      var chapterAllUrl =
          XPath.html(html).query(rule.bookInfo!.chapterUrl ?? "").attr ?? "";
      book.chapterList = await getBookChapterList(rule, chapterAllUrl);
    }
    //最新章节
    if(book.chapterList.isNotEmpty){
      book.lastChapter = book.chapterList.last.chapterName;
    }
    if(book.lastReadChapter?.isEmpty ?? true){
      book.lastReadChapter = book.chapterList.first.chapterName;
      book.lastReadIndex = 0;
      book.lastReadUrl = book.chapterList.first.chapterUrl;
      book.lastReadTime = DateUtil.nowTimestamp();
    }
    return book;
  }

  //获取章节列表
  Future<List<ChapterBean>> getBookChapterList(
      RuleBean rule, String chapterAllUrl) async {
    List<ChapterBean> chapterList = [];
    var html = await getData(rule.sourceUrl ?? "", chapterAllUrl);
    var chapters =
        XPath.html(html).query(rule.chapter?.chapterList ?? "").nodes;
    for (var element in chapters) {
      var chapterName =
          element.queryXPath(rule.chapter!.chapterName!).attr ?? "";
      var chapterUrl = element.queryXPath(rule.chapter!.chapterUrl!).attr;
      chapterList
          .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
    }
    //如果存在下一页 就继续加载
    if (rule.chapter?.nextPage == null) {
      var nextPage = XPath.html(html).query(rule.chapter!.nextPage!).attr;
      if (nextPage != null) {
        chapterList.addAll(await getBookChapterList(rule, nextPage));
      }
    }
    return chapterList;
  }

  ///获取章节内容
  Future<String> getChapterContent(RuleBean rule, String chapterUrl) async {
    var content = "";
    var html = await getData(rule.sourceUrl ?? "", chapterUrl);
    List<String?> contents =
        XPath.html(html).query(rule.chapterContent?.content ?? "").attrs;
    for (var element in contents) {
      content = "$content\n$element";
    }
    content =
        content.replaceAll(RegExp(rule.chapterContent?.replaceReg ?? ""), "");
    if (rule.chapterContent?.nextPage?.isNotEmpty ?? false) {
      var nextPage =
          XPath.html(html).query(rule.chapter?.nextPage ?? "").attr ?? "";
      if (nextPage.isNotEmpty) {
        var nextContent = await getChapterContent(rule, nextPage);
        if (nextContent.isEmpty) {
          content = "$content$nextContent";
        }
      }
    }
    print(content);
    return content;
  }
}
