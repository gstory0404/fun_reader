import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_page.dart';
import 'package:fun_reader/pages/find/find_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:fun_reader/pages/my/my_page.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:fun_reader/widgets/window_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopPage extends GetWidget<IndexCtr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
      child: WindowWidget(
        tabs: [
          WindowTab(title: Keys.bookshelf.tr,icon: Icons.home, page: BookShelfPage()),
          WindowTab(title: Keys.search.tr,icon: Icons.search, page: SearchPage()),
          WindowTab(title: Keys.find.tr,icon: Icons.domain, page: FindPage()),
          WindowTab(title: Keys.my.tr,icon: Icons.person, page: MyPage())
        ],
      ),
    );
  }
}
