import 'dart:async';

import 'package:fun_reader/manager/spider_manager.dart';
import 'package:fun_reader/pages/index/index_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/7 15:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class WelComeCtr extends GetxController{

  Timer? _timer;

  var countdown = 3.obs;

  @override
  void onInit() {
    super.onInit();
    //初始化爬虫规则
    SpiderManager().init();
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
}


