import 'package:fun_novel/pages/book/book_connect.dart';
import 'package:fun_novel/pages/book/book_ctr.dart';
import 'package:fun_novel/pages/book/book_page.dart';
import 'package:fun_novel/pages/category/category_connect.dart';
import 'package:fun_novel/pages/category/category_ctr.dart';
import 'package:fun_novel/pages/category/category_page.dart';
import 'package:fun_novel/pages/index/index_connect.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:fun_novel/pages/index/index_page.dart';
import 'package:fun_novel/pages/read/read_connect.dart';
import 'package:fun_novel/pages/read/read_ctr.dart';
import 'package:fun_novel/pages/read/read_page.dart';
import 'package:fun_novel/pages/search/search_ctr.dart';
import 'package:fun_novel/pages/search/search_page.dart';
import 'package:fun_novel/pages/welcome/welcome_ctr.dart';
import 'package:fun_novel/pages/welcome/welcome_page.dart';
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
        page: () => const WelcomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => WelComeCtr());
        }),
    ),
    GetPage(
      name: Routes.INDEX,
      page: () => const IndexPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<IndexConnect>(() => IndexConnect());
        Get.lazyPut(() => IndexCtr(connect: Get.find()));
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
  ];
}


