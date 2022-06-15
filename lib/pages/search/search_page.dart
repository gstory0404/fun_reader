import 'package:flutter/material.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/search/phone/search_phone_page.dart';
import 'package:fun_novel/pages/search/search_ctr.dart';
import 'package:fun_novel/routes/app_pages.dart';
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
    return Container();
  }

  @override
  Widget phonePage(BuildContext context) {
    return SearchPhonePage();
  }
}
