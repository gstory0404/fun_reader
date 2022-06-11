import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/entity/category_entity.dart';
import 'package:fun_novel/pages/category/category_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class CategoryCtr extends GetxController{
  CategoryConnect connect;
  var data = "".obs;

  //分类列表
  var categoryList = <CategoryEntity>[].obs;

  //分类书籍列表
  var categoryBookList = <BookBean>[].obs;

  //下一页
  String? nextPage;

  //当前选中
  var chooseIndex = 0.obs;

  ScrollController booksController = ScrollController();

  CategoryCtr({required this.connect});

  @override
  void onInit() {
    super.onInit();
    booksController.addListener(() {
      if (booksController.position.pixels ==
          booksController.position.maxScrollExtent) {
        if (nextPage?.isNotEmpty ?? false) {
          getCategoryData(nextPage!, isNew: false);
        }
      }
    });
  }

  @override
  void onReady() {
    if (connect.spiderManager.spiderBean != null) {
      chooseIndex.value = 0;
      getCategoryData(connect.spiderManager.spiderBean!.category!.url!);
    }
  }

  //获取分类列表
  Future<void> getCategoryData(String url, {bool isNew = true}) async {
    var html = await connect.getData(url);
    var books = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.books!)
        .nodes;
    categoryList.clear();
    if (isNew) {
      categoryBookList.clear();
    }
    //书籍
    for (var element in books) {
      var title = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.bookName!)
          .attr;
      var author = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.author!)
          .attr;
      var content = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.content!)
          .attr;
      var logo = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.logo!)
          .attr;
      var id = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.id!)
          .attr;
      categoryBookList.add(BookBean(
          title: title
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          author: author
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          content: content
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          logo: logo ?? "",
          id: id ?? ""));
    }
    print("${categoryBookList.length}");
    //分类
    var categorys = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.categorys!)
        .nodes;
    for (var element in categorys) {
      var categoryName = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.categoryName!)
          .attr;
      var categoryId = element
          .queryXPath(connect.spiderManager.spiderBean!.category!.categoryId!)
          .attr;
      categoryList.add(CategoryEntity(
          id: categoryId ?? "", name: categoryName?.replaceAll(" ", "") ?? ""));
    }
    //下一页
    var pages = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.nextId!)
        .attrs;
    nextPage = pages.last;
  }

  @override
  void dispose() {
    booksController.dispose();
    super.dispose();
  }
}

