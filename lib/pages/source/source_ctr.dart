import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 10:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SourceCtr extends GetxController {
  var rulelist = <DBRuleBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    queryAllRule();
  }

  void queryAllRule() async {
    rulelist.value = await RuleDao().queryAll();
  }

  void changeEffect(int index, bool isEffect) {
    print("$index $isEffect");
    rulelist[index].isEffect = isEffect;
    RuleDao().update(rulelist[index]);
    rulelist.refresh();
  }

  void deleteRule(DBRuleBean bean) {
    RuleDao().delete(bean);
    queryAllRule();
  }
}
