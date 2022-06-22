import 'package:desktop/desktop.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_page.dart';
import 'package:fun_reader/pages/find/find_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:fun_reader/pages/my/my_page.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopPage extends GetWidget<IndexCtr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 100),
      child: Nav(
        items: [
          NavItem(
            builder: (context, index) {
              return BookShelfPage();
            },
            title: Keys.bookshelf.tr,
            icon: Icons.home,
          ),
          NavItem(
            builder: (context, index) {
              return SearchPage();
            },
            title: Keys.searchHint.tr,
            icon: Icons.search,
          ),
          NavItem(
            builder: (context, index) {
              return FindPage();
            },
            title: Keys.find.tr,
            icon: Icons.domain,
          ),
          NavItem(
            builder: (context, index) {
              return MyPage();
            },
            title: Keys.my.tr,
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
