import 'package:flutter/cupertino.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/index/desktop/index_desktop_page.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:fun_novel/pages/index/phone/index_phone_page.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends BaseWidget<IndexCtr> {
  const IndexPage({Key? key}) : super(key: key);

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
