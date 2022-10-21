import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FindCtr extends BaseCtr {
  MyConnect connect = Get.find();

  var ruleList = <DBRuleBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    // _add();
    queryAllRule();
  }

  Future<void> queryAllRule() async {
    showLoading();
    ruleList.value = await RuleDao().queryAll(isEffect: true);
    if (ruleList.isEmpty) {
      showEmpty();
    } else {
      showMain();
    }
  }

  ///测试用例
  Future<void> _add() async {
    rootBundle.loadString("assets/json/rule.json").then((data) async {
      var map = json.decode(data);
      var bean = RuleBean.fromJson(map);
      var dbBean = await RuleDao().query(bean.sourceUrl ?? "");
      //如果不存在就插入表中
      if (dbBean == null) {
        DBRuleBean dbRuleBean = DBRuleBean();
        dbRuleBean.sourceUrl = bean.sourceUrl;
        dbRuleBean.sourceName = bean.sourceName;
        dbRuleBean.ruleBean = bean;
        dbRuleBean.isEffect = true;
        dbRuleBean.type = bean.type;
        RuleDao().insert(dbRuleBean);
      } else {
        //存在就更新
        dbBean.sourceUrl = bean.sourceUrl;
        dbBean.sourceName = bean.sourceName;
        dbBean.ruleBean = bean;
        RuleDao().update(dbBean);
      }
    });
  }
}
