import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryCtr extends GetxController {
  MyConnect connect = Get.find();

  //分类书籍列表
  var categoryBookList = <BookBean>[].obs;

  RuleBean? rule;

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
    //解析规则
    rule = connect.spiderManager.getRule(sourceUrl);
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
  Future<void> refreshData() async {
    if(rule == null){
      return;
    }
    isLoading.value = false;
    page = 1;
    categoryBookList.clear();
    categoryBookList.addAll(await connect.getCategoryBooks(rule!,path.replaceAll("&page&", "$page")));
  }

  //加载更多
  Future<void> loadMore() async {
    if(rule == null){
      return;
    }
    isLoading.value = true;
    page++;
    categoryBookList.addAll(await connect.getCategoryBooks(rule!,path.replaceAll("&page&", "$page")));
    isLoading.value = false;
  }

  @override
  void dispose() {
    booksController.dispose();
    super.dispose();
  }
}
