import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
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

  var rule = DBRuleBean().obs;
  var ruleList = <DBRuleBean>[].obs;

  var inputController = TextEditingController();

  SearchCtr();

  @override
  Future<void> onInit() async {
    super.onInit();
    queryAllRule();
  }

  ///获取所有书源
  void queryAllRule() async {
    ruleList.value = await RuleDao().queryAll(isEffect: true);
    if (ruleList.isNotEmpty) {
      rule.value = ruleList.first;
    }else{
      rule.value = DBRuleBean();
    }
    print("搜索源${rule.value.toJson()}");
  }

  //切换数据源
  void changeRule(DBRuleBean bean) {
    rule.value = bean;
  }

  Future<List<BookBean>> searchBook(String key) async {
    if (rule.value.sourceUrl?.isEmpty ?? true) {
      ToastUtil.showToast("请选择有效数据源");
      return [];
    }
    bookList.clear();
    bookList.addAll(await connect.getSearchBook(rule.value.ruleBean!,key)) ;
    return bookList;
  }
}
