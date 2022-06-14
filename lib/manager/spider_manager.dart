import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fun_novel/entity/rule_bean.dart';
import 'package:fun_novel/entity/spider_bean.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 10:39
/// @Email gstory0404@gmail.com
/// @Description: 解析数据管理类

class SpiderManager {
  SpiderManager._internal();

  factory SpiderManager() => _instance;

  static final SpiderManager _instance = SpiderManager._internal();

  //所有小说爬取规则
  List<RuleBean> ruleList = [];
  SpiderBean? spiderBean;

  void init(){
    rootBundle.loadString("assets/json/spider.json").then((value) {
      List list = json.decode(value);
      for (var element in list) {
        ruleList.add(RuleBean.fromJson(element));
      }
    });
  }

  //获取解析规则
  RuleBean getRule(String sourceUrl){
   return ruleList.firstWhere((element) => element.sourceUrl == sourceUrl);
  }
}


