import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_ctr.dart';
import 'package:fun_reader/pages/bookshelf/desktop/bookshelf_desktop_page.dart';
import 'package:fun_reader/pages/bookshelf/phone/bookshelf_phone_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:06
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookShelfPage extends BaseWidget<BookShelfCtr>{
  BookShelfCtr ctr = Get.put(BookShelfCtr());

  @override
  Widget desktopPage(BuildContext context) {
    return BookShelfDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return BookShelfPhonePage();
  }
}

