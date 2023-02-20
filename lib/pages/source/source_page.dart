import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/source/desktop/source_desktop_page.dart';
import 'package:fun_reader/pages/source/phone/source_phone_page.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 10:23
/// @Email gstory0404@gmail.com
/// @Description: 书源管理

class SourcePage extends BaseWidget{

  static void go(){
    Get.toNamed(Routes.SOURCE);
  }

  @override
  Widget desktopPage(BuildContext context) {
    return SourceDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return SourcePhonePage();
  }

}


