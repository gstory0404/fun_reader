import 'package:fun_novel/entity/category_book_entity.dart';
import 'package:fun_novel/entity/category_entity.dart';
import 'package:fun_novel/pages/index/index_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexCtr extends GetxController {
  IndexConnect connect;
  var data = "".obs;

  //分类列表
  var categoryList = <CategoryEntity>[].obs;

  //分类书籍列表
  var categoryBookList = <CategoryBookEntity>[].obs;

  //下一页
  String? nextPage = "";

  //当前选中
  var chooseIndex = 0.obs;

  IndexCtr({required this.connect});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (connect.spiderManager.spiderBean != null) {
      chooseIndex.value = 0;
      getCategoryData(connect.spiderManager.spiderBean!.category!.url!);
    }
  }

  Future<void> getCategoryData(String url, {bool isNew = true}) async {
    var html = await connect.getData(url);
    print(url + html);
    //书籍
    var titles = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.bookName!)
        .attrs;
    var authors = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.author!)
        .attrs;
    var contents = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.content!)
        .attrs;
    var logos = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.logo!)
        .attrs;
    var ids = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.id!)
        .attrs;
    //分类
    var categoryNames = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.categoryName!)
        .attrs;
    var categoryIds = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.categoryId!)
        .attrs;
    //下一页
    nextPage = XPath.html(html)
        .query(connect.spiderManager.spiderBean!.category!.nextId!)
        .attr;
    if (isNew) {
      categoryList.clear();
      categoryBookList.clear();
    }
    //分类列表
    for (int i = 0; i < categoryNames.length; i++) {
      categoryList.add(CategoryEntity(
          id: categoryIds[i]!, name: categoryNames[i]!.replaceAll(" ", "")));
    }

    //分类书籍列表
    for (int i = 0; i < titles.length; i++) {
      print(contents);
      categoryBookList.add(CategoryBookEntity(
          title: titles[i]!.replaceAll(" ", "").replaceAll("\n", "").replaceAll("\r;", ""),
          author: authors[i]!.replaceAll(" ", "").replaceAll("\n", "").replaceAll("\r;", ""),
          content: contents[i]!.replaceAll(" ", "").replaceAll("\n", "").replaceAll("\r;", ""),
          logo: logos[i]!,
          id: ids[i]!));
    }
  }
}
