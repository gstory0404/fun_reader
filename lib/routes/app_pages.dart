import 'package:fun_reader/pages/about/about_page.dart';
import 'package:fun_reader/pages/book/book_ctr.dart';
import 'package:fun_reader/pages/book/book_page.dart';
import 'package:fun_reader/pages/category/category_ctr.dart';
import 'package:fun_reader/pages/category/category_page.dart';
import 'package:fun_reader/pages/comic/comic_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:fun_reader/pages/index/index_page.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:fun_reader/pages/read/read_page.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:fun_reader/pages/source/source_ctr.dart';
import 'package:fun_reader/pages/source/source_page.dart';
import 'package:fun_reader/pages/welcome/welcome_ctr.dart';
import 'package:fun_reader/pages/welcome/welcome_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 15:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AppPages {
  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WelcomeCtr());
      }),
    ),
    GetPage(
      name: Routes.INDEX,
      page: () => IndexPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => IndexCtr());
      }),
    ),
    GetPage(
      name: Routes.CATRGORY,
      page: () => CategoryPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CategoryCtr());
      }),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SearchCtr());
      }),
    ),
    GetPage(
      name: Routes.BOOK,
      page: () => BookPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => BookCtr());
      }),
    ),
    GetPage(
      name: Routes.READ,
      page: () => ReadPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReadCtr());
      }),
    ),
    GetPage(
      name: Routes.SOURCE,
      page: () => SourcePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SourceCtr());
      }),
    ),
    GetPage(
      name: Routes.ABOUT,
      page: () => AboutPage(),
    ),
    GetPage(
      name: Routes.COMIC,
      page: () => ComicPage(),
    ),
  ];
}
