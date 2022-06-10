import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/category/category_connect.dart';
import 'package:fun_novel/pages/category/category_ctr.dart';
import 'package:fun_novel/pages/category/category_desktop_page.dart';
import 'package:fun_novel/pages/category/category_phone_page.dart';
import 'package:fun_novel/pages/index/index_desktop_page.dart';
import 'package:fun_novel/pages/index/index_phone_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:25
/// @Email gstory0404@gmail.com
/// @Description: 分类页面

class CategoryPage extends BaseWidget<CategoryCtr>{

  CategoryCtr ctr = Get.put(CategoryCtr(connect: Get.put(CategoryConnect())));

  @override
  Widget desktopPage() {
    return CategoryDesktopPage();
  }

  @override
  Widget phonePage() {
    return CategoryPhonePage();
  }

}

