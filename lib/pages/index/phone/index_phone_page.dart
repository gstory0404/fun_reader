import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_page.dart';
import 'package:fun_reader/pages/find/find_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:fun_reader/pages/my/my_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPhonePage extends GetWidget<IndexCtr> {
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: Keys.bookshelf.tr),
      BottomNavigationBarItem(icon: const Icon(Icons.domain), label: Keys.find.tr),
      BottomNavigationBarItem(icon: const Icon(Icons.person), label: Keys.my.tr)
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.chooseIndex.value = index;
      },
      children: <Widget>[
        BookShelfPage(),
        FindPage(),
        MyPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.chooseIndex.value,
          onTap: (index) {
            controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
            controller.chooseIndex.value = index;
          },
          items: buildBottomNavBarItems(),
        ),
      ),
    );
  }
}
