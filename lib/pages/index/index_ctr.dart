import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/entity/category_entity.dart';
import 'package:fun_novel/pages/index/index_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexCtr extends GetxController with GetTickerProviderStateMixin{
  IndexConnect connect;

   TabController? tabController;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  var chooseIndex = 0.obs;

  IndexCtr({required this.connect});

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
