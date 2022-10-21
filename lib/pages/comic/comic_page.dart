import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/comic/comic_ctr.dart';
import 'package:fun_reader/pages/comic/desktop/comic_desktop_page.dart';
import 'package:fun_reader/pages/comic/phone/comic_phone_page.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/10/21 12:08
/// @Email gstory0404@gmail.com
/// @Description: 漫画

class ComicPage extends BaseWidget<ComicCtr> {
  ComicCtr ctr = Get.put(ComicCtr());

  static void go(
      {required String sourceUrl,
      required String bookUrl,
      required int chapterIndex}) {
    Get.toNamed(Routes.COMIC, arguments: {
      "sourceUrl": sourceUrl,
      "bookUrl": bookUrl,
      "chapterIndex": chapterIndex
    });
  }

  @override
  Widget desktopPage(BuildContext context) {
    return ComicDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return ComicPhonePage();
  }
}
