import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/my/my_ctr.dart';
import 'package:fun_reader/pages/my/phone/my_phone_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/21 18:01
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class MyPage extends BaseWidget<MyCtr>{

  MyCtr myCtr = Get.put(MyCtr());

  @override
  Widget desktopPage(BuildContext context) {
     return Container();
  }

  @override
  Widget phonePage(BuildContext context) {
    return MyPhonePage();
  }

}

