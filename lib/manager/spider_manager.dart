import 'dart:convert';

import 'package:flutter/services.dart';
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
  List<SpiderBean> spiderList = [];
  SpiderBean? spiderBean;


  void init(){
    rootBundle.loadString("assets/json/spider.json").then((value) {
      List list = json.decode(value);
      for (var element in list) {
        spiderList.add(SpiderBean.fromJson(element));
      }
      if(spiderList.isNotEmpty){
        chooseSpider(spiderList[0].type ?? "");
      }

    });
  }

  //切换数据源
  void chooseSpider(String type){
    for (var element in spiderList) {
      if(element.type == type){
        spiderBean = element;
      }
    }
  }
}


