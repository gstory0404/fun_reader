import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/entity/category_entity.dart';
import 'package:fun_novel/manager/my_connect.dart';
import 'package:fun_novel/pages/category/category_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryCtr extends GetxController {
  MyConnect connect = Get.find();

  //分类书籍列表
  var categoryBookList = <BookBean>[].obs;

  var sourceUrl = "";
  var path = "";
  var name = "".obs;

  //下一页
  int page = 1;

  var isLoading = false.obs;

  ScrollController booksController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    name.value = Get.arguments["name"];
    sourceUrl = Get.arguments["sourceUrl"];
    path = Get.arguments["path"];
    booksController.addListener(() {
      if (booksController.position.pixels ==
          booksController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  @override
  void onReady() {
    refreshData();
  }

  //刷新
  void refreshData() {
    page = 1;
    getCategoryBooks(path.replaceAll("&page&", "$page"));
  }

  //加载更多
  Future<void> loadMore() async {
    isLoading.value = true;
    page++;
    getCategoryBooks(path.replaceAll("&page&", "$page"), isNew: false);
  }

  //获取分类书籍列表
  Future<void> getCategoryBooks(String path, {bool isNew = true}) async {
    print(path);
    var html = await connect.getData(sourceUrl, path);
    print(html);
    //规则
    var rule = connect.spiderManager.getRule(sourceUrl);
    var books = XPath.html(html).query(rule.recommendBooks!.books!).nodes;
    if (isNew) {
      categoryBookList.clear();
    }
    isLoading.value = false;
    //书籍
    for (var element in books) {
      var bookUrl = element.queryXPath(rule.recommendBooks!.bookUrl!).attr;
      var name = element.queryXPath(rule.recommendBooks!.name!).attr;
      var author = element.queryXPath(rule.recommendBooks!.author!).attr;
      var intro = element.queryXPath(rule.recommendBooks!.intro!).attr;
      var cover = element.queryXPath(rule.recommendBooks!.cover!).attr;
      var category = element.queryXPath(rule.recommendBooks!.category!).attrs;
      var lastChapter =
          element.queryXPath(rule.recommendBooks!.lastChapter!).attr;
      categoryBookList.add(BookBean(
          bookUrl: bookUrl,
          name: name ?? "",
          author: author ?? "",
          intro: intro ?? "",
          cover: cover ?? "",
          category: category,
          lastChapter: lastChapter ?? ""));
    }
  }

  @override
  void dispose() {
    booksController.dispose();
    super.dispose();
  }
}
