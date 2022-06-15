import 'package:flutter/material.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/find/find_body.dart';
import 'package:fun_novel/pages/find/find_ctr.dart';
import 'package:fun_novel/pages/search/search_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:24
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FindPage extends BaseWidget<FindCtr> {

  FindCtr ctr = Get.put(FindCtr());

  @override
  Widget desktopPage(BuildContext context) {
    return Scaffold(
      body: FindBody(),
    );
  }

  @override
  Widget phonePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发现"),
        actions: [
          // 搜索
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                SearchPage.go();
              }),
        ],
      ),
      body: FindBody(),
    );
  }
}
