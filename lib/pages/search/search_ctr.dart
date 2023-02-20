import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/search_bean.dart';
import 'package:fun_reader/lang/keys.dart';
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
  var searchBooks = <SearchBean>[];

  var ruleList = <DBRuleBean>[];

  var types = [Keys.novel.tr,Keys.comic.tr];
  int choose = 1;

  var inputController = TextEditingController();

  SearchCtr();

  @override
  Future<void> onInit() async {
    super.onInit();
    queryAllRule();
  }

  void changeType(String type){
    for(int i= 0;i<types.length ;i ++){
      if(type == types[i]){
        choose = i + 1;
        update();
      }
    }
  }

  ///获取所有书源
  void queryAllRule() async {
    ruleList.clear();
    var list = await RuleDao().queryAll(isEffect: true);
    //过滤搜索规则不存在的
    for (var element in list) {
      if (element.ruleBean?.search != null) {
        ruleList.add(element);
      }
    }
  }

  Future<void> searchBook(String key) async {
    if (ruleList.isEmpty) {
      ToastUtil.showToast("暂无数据源");
      return;
    }
    searchBooks.clear();
    for (var element in ruleList) {
      print(element.ruleBean?.toJson());
      if (element.ruleBean != null && ((element.type == null || element.type == 1) || element.type == choose)) {
        connect.getSearchBook(element.ruleBean!, key).then((value) => {
              print("${element.ruleBean?.sourceName}"),
              if (value.isNotEmpty)
                {
                  searchBooks.add(SearchBean(rule: element, books: value)),
                  update()
                }
            });
      }
    }
  }
}
