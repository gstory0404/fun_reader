import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/chapter_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:fun_reader/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';
import 'package:xpath_selector_html_parser/xpath_selector_html_parser.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MyConnect extends GetConnect {
  List<String> agents = [];

  @override
  void onInit() {
    rootBundle.loadString("assets/json/agent.json").then((value) {
      List list = json.decode(value);
      for (var element in list) {
        agents.add(element);
      }
    });
  }

  String getRandomAgent() {
    if (agents.isEmpty) {
      return "";
    }
    var index = Random().nextInt(agents.length - 1);
    return agents[index];
  }

  //get请求
  Future<String> getData(String sourceUrl, String path,
      {Map<String, dynamic>? query}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    httpClient.timeout = const Duration(seconds: 60);
    Map<String, String> head = {};
    DBRuleBean? dbRuleBean = await RuleDao().query(sourceUrl);
    //添加head
    head["Referer"] = "$sourceUrl$path";
    head["accept"] = "*/*";
    head["accept-encoding"] = "gzip, deflate, br";
    head["accept-language"] = "zh-CN,zh;q=0.9";
    head["connection"] = "keep-alive";
    if (dbRuleBean?.ruleBean?.head?.isNotEmpty ?? false) {
      var ruleHead = json.decode(dbRuleBean!.ruleBean!.head!);
      ruleHead.forEach((key, value) {
        head[key] = value;
      });
    }
    //添加User-Agent
    httpClient.sendUserAgent = true;
    httpClient.userAgent = getRandomAgent();
    Response<String> response = await get(path, query: query, headers: head);
    return response.body ?? "";
  }

  //post请求
  Future<String> postData(
      String sourceUrl, String path, Map<String, dynamic> body,
      {String? contentType}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    Map<String, String> head = {};
    DBRuleBean? dbRuleBean = await RuleDao().query(sourceUrl);
    //添加head
    head["Referer"] = "$sourceUrl$path";
    head["accept"] = "*/*";
    head["accept-encoding"] = "gzip, deflate, br";
    head["accept-language"] = "zh-CN,zh;q=0.9";
    head["connection"] = "keep-alive";
    if (dbRuleBean?.ruleBean?.head?.isNotEmpty ?? false) {
      var ruleHead = json.decode(dbRuleBean!.ruleBean!.head!);
      ruleHead.forEach((key, value) {
        head[key] = value;
      });
    }
    //添加User-Agent
    httpClient.sendUserAgent = true;
    httpClient.userAgent = getRandomAgent();
    Response<String> response = await post(path, body,
        headers: head, contentType: contentType, query: body);
    return response.body ?? "";
  }

  ///获取分类书籍列表
  Future<List<BookBean>> getCategoryBooks(DBRuleBean rule, String path) async {
    List<BookBean> bookList = [];
    var html = await getData(rule.sourceUrl ?? "", path);
    var books =
        HtmlXPath.html(html).query(rule.ruleBean!.recommendBooks!.books!).nodes;
    //书籍
    for (var element in books) {
      var bookUrl =
          element.queryXPath(rule.ruleBean!.recommendBooks!.bookUrl!).attr;
      var name =
          element.queryXPath(rule.ruleBean!.recommendBooks!.name!).attr?.trim();
      var author = element
          .queryXPath(rule.ruleBean!.recommendBooks!.author!)
          .attr
          ?.trim();
      var intro = element
          .queryXPath(rule.ruleBean!.recommendBooks!.intro!)
          .attr
          ?.trim();
      var cover =
          element.queryXPath(rule.ruleBean!.recommendBooks!.cover!).attr;
      if (cover != null && !cover.startsWith("http")) {
        cover = "${rule.sourceUrl}$cover";
      }
      var category =
          element.queryXPath(rule.ruleBean!.recommendBooks!.category!).attrs;
      var lastChapter = element
          .queryXPath(rule.ruleBean!.recommendBooks!.lastChapter!)
          .attr
          ?.trim();
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
    print("${rule.sourceUrl!}${rule.search!.url!}");
    print(html);
    var books = HtmlXPath.html(html).query(rule.searchBooks!.books!).nodes;
    //书籍
    for (var element in books) {
      var bookUrl = element.queryXPath(rule.searchBooks!.bookUrl!).attr;
      var name = element.queryXPath(rule.searchBooks!.name!).attr?.trim();
      var author = element.queryXPath(rule.searchBooks!.author!).attr?.trim();
      var intro = element.queryXPath(rule.searchBooks!.intro!).attr?.trim();
      var cover = element.queryXPath(rule.searchBooks!.cover!).attr;
      if (cover != null && !cover.startsWith("http")) {
        cover = "${rule.sourceUrl}$cover";
      }
      var category = element.queryXPath(rule.searchBooks!.category!).attrs;
      var lastChapter =
          element.queryXPath(rule.searchBooks!.lastChapter!).attr?.trim();
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
    if (book.id == null) {
      book.sourceName = rule.sourceName;
      book.sourceUrl = rule.sourceUrl;
      book.bookUrl = bookUrl;
      book.type = rule.type;
    }
    var html = await getData(rule.sourceUrl ?? "", bookUrl);
    book.bookName =
        HtmlXPath.html(html).query(rule.bookInfo!.name ?? "").attr?.trim() ??
            "";
    book.cover =
        HtmlXPath.html(html).query(rule.bookInfo!.cover ?? "").attr ?? "";
    if (book.cover != null && !book.cover!.startsWith("http")) {
      book.cover = "${rule.sourceUrl}${book.cover}";
    }
    book.author =
        HtmlXPath.html(html).query(rule.bookInfo!.author ?? "").attr?.trim() ??
            "";
    book.category =
        HtmlXPath.html(html).query(rule.bookInfo!.category ?? "").attrs;
    book.updateTime = HtmlXPath.html(html)
            .query(rule.bookInfo!.updateTime ?? "")
            .attr
            ?.trim() ??
        "";
    book.intro =
        HtmlXPath.html(html).query(rule.bookInfo!.intro ?? "").attr?.trim() ??
            "";
    //最新章节
    book.lastChapter = HtmlXPath.html(html)
            .query(rule.bookInfo!.lastChapter ?? "")
            .attr
            ?.trim() ??
        "";
    //如果章节列表 规则为空则在当前页面解析 章节列表
    if (rule.bookInfo!.chapterUrl?.isEmpty ?? true) {
      var chapters =
          HtmlXPath.html(html).query(rule.chapter?.chapterList ?? "").nodes;
      for (var element in chapters) {
        var chapterName =
            element.queryXPath(rule.chapter?.chapterName ?? "").attr?.trim() ??
                "";
        var chapterUrl =
            element.queryXPath(rule.chapter?.chapterUrl ?? "").attr?.trim() ??
                "";
        book.chapterList
            .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
      }
    } else {
      var chapterAllUrl =
          HtmlXPath.html(html).query(rule.bookInfo!.chapterUrl ?? "").attr ??
              "";
      book.chapterList = await getBookChapterList(rule, chapterAllUrl);
    }
    if (book.lastReadChapter?.isEmpty ?? false) {
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
        HtmlXPath.html(html).query(rule.chapter?.chapterList ?? "").nodes;
    for (var element in chapters) {
      var chapterName =
          element.queryXPath(rule.chapter!.chapterName!).attr ?? "";
      var chapterUrl = element.queryXPath(rule.chapter!.chapterUrl!).attr;
      chapterList
          .add(ChapterBean(chapterName: chapterName, chapterUrl: chapterUrl));
    }
    //如果存在下一页 就继续加载
    if (rule.chapter?.nextPage == null) {
      var nextPage = HtmlXPath.html(html).query(rule.chapter!.nextPage!).attr;
      if (nextPage != null) {
        chapterList.addAll(await getBookChapterList(rule, nextPage));
      }
    }
    return chapterList;
  }

  ///获取小说章节内容
  Future<String> getChapterContent(RuleBean rule, String chapterUrl) async {
    var content = "";
    var html = await getData(rule.sourceUrl ?? "", chapterUrl);
    List<String?> contents =
        HtmlXPath.html(html).query(rule.chapterContent?.content ?? "").attrs;
    for (var element in contents) {
      content = "$content$element";
    }
    content = content.replaceAll("　　", "\n　　");
    content =
        content.replaceAll(RegExp(rule.chapterContent?.replaceReg ?? ""), "");

    if (rule.chapterContent?.nextPage?.isNotEmpty ?? false) {
      var nextPage =
          HtmlXPath.html(html).query(rule.chapter?.nextPage ?? "").attr ?? "";
      if (nextPage.isNotEmpty) {
        var nextContent = await getChapterContent(rule, nextPage);
        if (nextContent.isEmpty) {
          content = "$content$nextContent";
        }
      }
    }
    return content;
  }

  ///获取漫画章节内容
  Future<List<String?>> getComicChapterContent(
      RuleBean rule, String chapterUrl) async {
    print(chapterUrl);
    var html = await getData(rule.sourceUrl ?? "", chapterUrl);
    // List<String?> contents =
    //     XPath.html(html).query(rule.chapterContent?.content ?? "").attrs;
    List<String?> content =
        HtmlXPath.html(html).query("//*[@class=\"erPag\"]//mip-img/@src").attrs;
    if (rule.chapterContent?.nextPage?.isNotEmpty ?? false) {
      var nextPage =
          HtmlXPath.html(html).query(rule.chapter?.nextPage ?? "").attr ?? "";
      if (nextPage.isNotEmpty) {
        var nextContent = await getComicChapterContent(rule, nextPage);
        if (nextContent.isEmpty) {
          content.addAll(nextContent);
        }
      }
    }
    return content;
  }
}
