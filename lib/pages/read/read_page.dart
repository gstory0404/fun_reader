import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/read/phone/read_phone_page.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadPage extends BaseWidget<ReadCtr>{

  static void go({required String sourceUrl,required String bookUrl,required int chapterIndex}){
    Get.toNamed(Routes.READ, arguments: {
      "sourceUrl": sourceUrl,
      "bookUrl": bookUrl,
      "chapterIndex": chapterIndex
    });
  }

  @override
  Widget desktopPage(BuildContext context) {
    return ReadPhonePage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return ReadPhonePage();
  }
}

