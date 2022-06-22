import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/find/desktop/find_desktop_page.dart';
import 'package:fun_reader/pages/find/find_ctr.dart';
import 'package:fun_reader/pages/find/phone/find_phone_page.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:24
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FindPage extends BaseWidget<FindCtr> {
  FindCtr ctr = Get.put(FindCtr());

  @override
  Widget desktopPage(BuildContext context) {
    return FindDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return FindPhonePage();
  }
}
