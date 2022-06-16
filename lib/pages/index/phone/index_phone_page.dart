import 'package:flutter/material.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_page.dart';
import 'package:fun_reader/pages/find/find_page.dart';
import 'package:fun_reader/pages/index/index_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPhonePage extends GetWidget<IndexCtr> {
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "书架"),
      BottomNavigationBarItem(icon: new Icon(Icons.domain), label: "发现"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的")
    ];
  }

  Widget buildPageView() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.chooseIndex.value = index;
      },
      children: <Widget>[
        BookshelfPage(),
        FindPage(),
        BookshelfPage(),
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
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("FunNovel"),
    //     actions: <Widget>[
    //       // 搜索
    //       IconButton(
    //           icon: const Icon(Icons.search),
    //           onPressed: () {
    //             // Get.toNamed(Routes.SEARCH);
    //             showSearch(context: context, delegate: SearchBarDelegate());
    //           }),
    //       // 菜单
    //       PopupMenuButton<String>(
    //         itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
    //           _selectView(Icons.book, '书源', 'book'),
    //           _selectView(Icons.settings, '设置', 'setting'),
    //         ],
    //         onSelected: (String action) {
    //           switch (action) {
    //             case 'setting':
    //               break;
    //             case 'book':
    //               break;
    //           }
    //         },
    //       ),
    //     ],
    //     bottom: TabBar(
    //       controller: controller.tabController,
    //       tabs: const <Tab>[
    //         Tab(text: "书架"),
    //         Tab(text: "分类"),
    //       ],
    //     ),
    //   ),
    //   body: TabBarView(
    //     controller: controller.tabController,
    //     children: [
    //       BookshelfPage(),
    //       CategoryPage(),
    //     ],
    //   ),
    // );
  }

  //菜单
  _selectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Colors.black),
            Text(text),
          ],
        ));
  }
}
