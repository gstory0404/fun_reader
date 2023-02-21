import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/db_manager.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/sp_manager.dart';
import 'package:fun_reader/pages/index/index_page.dart';
import 'package:get/get.dart';

class WelcomeCtr extends GetxController {
  Timer? _timer;

  var countdown = 3;

  @override
  Future<void> onInit() async {
    super.onInit();
    //链接数据库
    await DBManager.getDatabase();
    await SPManager().init();
    _timer = Timer.periodic(const Duration(seconds: 1),(timer){
      if (countdown > 0) {
        countdown--;
      } else {
        _timer?.cancel();
        _timer = null;
        IndexPage.go();
      }
    });
    // _addTest();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
  }

  ///测试用例
  Future<void> _addTest() async {
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
