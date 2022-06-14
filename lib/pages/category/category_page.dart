import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/category/category_connect.dart';
import 'package:fun_novel/pages/category/category_ctr.dart';
import 'package:fun_novel/pages/category/desktop/category_desktop_page.dart';
import 'package:fun_novel/pages/category/phone/category_phone_page.dart';
import 'package:fun_novel/pages/index/desktop/index_desktop_page.dart';
import 'package:fun_novel/pages/index/phone/index_phone_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:25
/// @Email gstory0404@gmail.com
/// @Description: 分类页面

class CategoryPage extends BaseWidget<CategoryCtr>{

  @override
  Widget desktopPage(BuildContext context) {
    return CategoryDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return CategoryPhonePage();
  }
}

