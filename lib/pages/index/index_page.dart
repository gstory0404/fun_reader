import 'package:flutter/cupertino.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/index/desktop/index_desktop_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:fun_reader/pages/index/phone/index_phone_page.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends BaseWidget {
  IndexCtr ctr = Get.put(IndexCtr());

  IndexPage({Key? key}) : super(key: key);

  static void go(){
    Get.offAllNamed(Routes.INDEX);
  }

  @override
  Widget desktopPage(BuildContext context) {
    return IndexDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return IndexPhonePage();
  }
}
