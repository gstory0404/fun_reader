import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/search/desktop/search_desktop_page.dart';
import 'package:fun_reader/pages/search/phone/search_phone_page.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPage extends BaseWidget<SearchCtr> {

  static void go(){
    Get.toNamed(Routes.SEARCH);
  }

  @override
  Widget desktopPage(BuildContext context) {
    return SearchDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return SearchPhonePage();
  }
}
