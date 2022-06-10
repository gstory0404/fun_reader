import 'package:flutter/material.dart';
import 'package:fun_novel/pages/bookshelf/bookshelf_page.dart';
import 'package:fun_novel/pages/category/category_page.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:fun_novel/pages/search/search_phone_page.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPhonePage extends GetWidget<IndexCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FunNovel"),
        actions: <Widget>[
          // 搜索
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Get.toNamed(Routes.SEARCH);
                showSearch(context: context, delegate: SearchBarDelegate());
              }),
          // 菜单
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              _selectView(Icons.settings, '设置', 'setting'),
            ],
            onSelected: (String action) {
              switch (action) {
                case 'setting':
                  break;
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          tabs: const <Tab>[
            Tab(text: "书架"),
            Tab(text: "分类"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          BookshelfPage(),
          CategoryPage(),
        ],
      ),
    );
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
