import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexCtr extends BaseCtr with GetTickerProviderStateMixin{

   TabController? tabController;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var chooseIndex = 0;

  IndexCtr();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  void changeIndex(int index){
    chooseIndex = index;
    update();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
