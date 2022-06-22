import 'package:flutter/material.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/book/book_ctr.dart';
import 'package:fun_reader/pages/book/desktop/book_desktop_page.dart';
import 'package:fun_reader/pages/book/phone/book_phone_page.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookPage extends BaseWidget<BookCtr>{

  static void go({required String sourceUrl,required String bookUrl}){
    Get.toNamed(Routes.BOOK,
        arguments: {"sourceUrl": sourceUrl, "bookUrl": bookUrl});
  }

  @override
  Widget desktopPage(BuildContext context) {
    return BookDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return BookPhonePage();
  }

}

