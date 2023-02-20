import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryCtr extends BaseCtr {
  MyConnect connect = Get.find();

  //分类书籍列表
  var categoryBookList = <BookBean>[];

  DBRuleBean? rule;

  var sourceUrl = "";
  var path = "";
  var name = "";

  //下一页
  int page = 1;

  var isLoading = false;

  ScrollController booksController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    name = Get.arguments["name"];
    sourceUrl = Get.arguments["sourceUrl"];
    path = Get.arguments["path"];
    //解析规则
    rule = await RuleDao().query(sourceUrl);
    booksController.addListener(() {
      if (booksController.position.pixels ==
          booksController.position.maxScrollExtent) {
        loadMore();
      }
    });
    showLoading();
    refreshData();
  }

  //刷新
  Future<void> refreshData() async {
    if (rule == null) {
      ToastUtil.showToast("获取解析规则失败");
      Get.back();
      return;
    }
    isLoading = false;
    page = 1;
    categoryBookList.clear();
    categoryBookList.addAll(await connect.getCategoryBooks(
        rule!, path.replaceAll("&page&", "$page")));
    if (categoryBookList.isEmpty) {
      showEmpty();
    } else {
      showMain();
    }
    update();
  }

  //加载更多
  Future<void> loadMore() async {
    if (rule == null) {
      return;
    }
    isLoading = true;
    page++;
    categoryBookList.addAll(await connect.getCategoryBooks(
        rule!, path.replaceAll("&page&", "$page")));
    isLoading = false;
    update();
  }

  @override
  void dispose() {
    booksController.dispose();
    super.dispose();
  }
}
