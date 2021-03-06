import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchCtr extends BaseCtr {
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
    ruleList.clear();
    var list = await RuleDao().queryAll(isEffect: true);
    //过滤搜索规则不存在的
    for (var element in list) {
      if(element.ruleBean?.search != null){
        ruleList.add(element);
      }
    }
    if (ruleList.isNotEmpty) {
      rule.value = ruleList.first;
    }else{
      rule.value = DBRuleBean();
    }
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
    showLoading();
    bookList.clear();
    bookList.addAll(await connect.getSearchBook(rule.value.ruleBean!,key)) ;
    if(bookList.isEmpty){
      showEmpty();
    }else{
      showMain();
    }
    return bookList;
  }
}
