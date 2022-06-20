import 'dart:convert';
import 'dart:convert' as convert;

import 'package:fun_reader/entity/rule_bean.dart';

/// @CreateDate: 2022/6/20 15:14
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class DBRuleBean {
  int? id;
  String? sourceName;
  String? sourceUrl;
  String? rule;
  bool isEffect = false;
  RuleBean? ruleBean; 

  DBRuleBean({this.id,this.sourceName,this.sourceUrl,this.rule});

  DBRuleBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sourceName = json['source_name'];
    sourceUrl = json['sourceUrl'];
    rule = json['rule'];
    isEffect = json['is_effect'] == 1;
    ruleBean = RuleBean.fromJson(convert.jsonDecode(rule ?? ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['source_name'] = sourceName;
    data['source_url'] = sourceUrl;
    data['rule'] = json.encode(ruleBean);
    data['is_effect'] = isEffect ? 1 : 0;
    return data;
  }
}
