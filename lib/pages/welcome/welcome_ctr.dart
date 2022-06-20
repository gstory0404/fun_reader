import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/sp_manager.dart';
import 'package:fun_reader/pages/index/index_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/7 15:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class WelComeCtr extends GetxController{

  Timer? _timer;

  var countdown = 3.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    //初始化爬虫规则
    // initRule();
    await SPManager().init();
    _timer = Timer.periodic(Duration(seconds: 1),(timer){
      if (countdown > 0) {
        countdown--;
      } else {
        _timer?.cancel();
        _timer = null;
        IndexPage.go();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
  }

  //模拟一个规则
  void initRule() async{
    rootBundle.loadString("assets/json/spider.json").then((value) async {
      List list = json.decode(value);
      for (var element in list) {
        RuleBean bean = RuleBean.fromJson(element);
        var dbBean = await RuleDao().query(bean.sourceUrl ?? "");
        if(dbBean?.id == null){
          DBRuleBean dbRuleBean = DBRuleBean();
          dbRuleBean.sourceUrl = bean.sourceUrl;
          dbRuleBean.sourceName = bean.sourceName;
          dbRuleBean.ruleBean = bean;
          dbRuleBean.isEffect = true;
          RuleDao().insert(dbRuleBean);
        }
      }
    });
  }
}


