import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class FindCtr extends BaseCtr{
  MyConnect connect = Get.find();

  var rulelist = <DBRuleBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    queryAllRule();
  }

  Future<void> queryAllRule() async{
    showLoading();
    rulelist.value = await RuleDao().queryAll(isEffect: true);
    if(rulelist.isEmpty){
      showEmpty();
    }else{
      showMain();
    }
  }
}


