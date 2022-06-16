import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class FindCtr extends GetxController{
  MyConnect connect = Get.find();

  var rulelist = <RuleBean>[].obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
    rulelist.value = connect.spiderManager.ruleList;
  }
}


