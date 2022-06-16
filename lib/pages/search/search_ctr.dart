import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

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

  //切换数据源
  void changeRule(RuleBean bean) {
    rule.value = bean;
  }

  Future<List<BookBean>> searchBook(String key) async {
    if (rule.value.sourceUrl?.isEmpty ?? true) {
      ToastUtil.showToast("请选择有效数据源");
      return [];
    }
    bookList.clear();
    bookList.addAll(await connect.getSearchBook(rule.value,key)) ;
    return bookList;
  }
}
