import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/entity/rule_bean.dart';
import 'package:fun_novel/manager/my_connect.dart';
import 'package:fun_novel/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchCtr extends GetxController {
  MyConnect connect = Get.find();

  //分类书籍列表
  var bookList = <BookBean>[].obs;

  var rule = RuleBean().obs;

  var inputController = TextEditingController();

  SearchCtr();

  @override
  void onInit() {
    super.onInit();
    if (connect.spiderManager.ruleList.isNotEmpty) {
      rule.value = connect.spiderManager.ruleList.first;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  //切换数据源
  void changeRule(RuleBean bean) {
    rule.value = bean;
  }

  //搜索小说
  Future<List<BookBean>> searchBook(String key) async {
    if (rule.value.sourceUrl?.isEmpty ?? true) {
      EasyLoading.showToast('请选择有效数据源');
      return [];
    }
    bookList.clear();
    var body = rule.value.search!.body!;
    body = body.replaceAll("&key&", key);
    var map = json.decode(body);
    String html;
    if (rule.value.search?.method == "POST") {
      html = await connect.postData(
          rule.value.sourceUrl!, rule.value.search!.url!, map,
          contentType: rule.value.search!.contentType);
    } else {
      html = await connect
          .getData(rule.value.sourceUrl!, rule.value.search!.url!, query: map);
    }
    var books = XPath.html(html).query(rule.value.searchBooks!.books!).nodes;
    //书籍
    for (var element in books) {
      var bookUrl = element.queryXPath(rule.value.searchBooks!.bookUrl!).attr;
      var name = element.queryXPath(rule.value.searchBooks!.name!).attr;
      var author = element.queryXPath(rule.value.searchBooks!.author!).attr;
      var intro = element.queryXPath(rule.value.searchBooks!.intro!).attr;
      var cover = element.queryXPath(rule.value.searchBooks!.cover!).attr;
      var category =
          element.queryXPath(rule.value.searchBooks!.category!).attrs;
      var lastChapter =
          element.queryXPath(rule.value.searchBooks!.lastChapter!).attr;
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
}
