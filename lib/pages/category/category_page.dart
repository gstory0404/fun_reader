import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_reader/pages/base/base_widget.dart';
import 'package:fun_reader/pages/category/category_ctr.dart';
import 'package:fun_reader/pages/category/desktop/category_desktop_page.dart';
import 'package:fun_reader/pages/category/phone/category_phone_page.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 15:25
/// @Email gstory0404@gmail.com
/// @Description: 分类页面

class CategoryPage extends BaseWidget{

  final categoryCtr = Get.put(CategoryCtr());

  static void go({required name,required sourceUrl,required path}){
    Get.toNamed(Routes.CATRGORY, arguments: {
      "name": name,
      "sourceUrl": sourceUrl,
      "path": path
    });
  }

  @override
  Widget desktopPage(BuildContext context) {
    return CategoryDesktopPage();
  }

  @override
  Widget phonePage(BuildContext context) {
    return CategoryPhonePage();
  }
}

