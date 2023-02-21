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

class IndexPhonePage extends StatelessWidget {
  IndexCtr ctr = Get.find();

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: const Icon(Icons.home), label: Keys.bookshelf.tr),
      BottomNavigationBarItem(
          icon: const Icon(Icons.domain), label: Keys.find.tr),
      BottomNavigationBarItem(icon: const Icon(Icons.person), label: Keys.my.tr)
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: ctr.pageController,
      onPageChanged: ctr.changeIndex,
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
      bottomNavigationBar: GetBuilder<IndexCtr>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.chooseIndex,
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            selectedIconTheme: const IconThemeData(color: Color(0xFF12aa9c)),
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            selectedLabelStyle: const TextStyle(color: Color(0xFF12aa9c)),
            onTap: (index) {
              controller.pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              controller.changeIndex(index);
            },
            items: buildBottomNavBarItems(),
          );
        },
      ),
    );
  }
}
