import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/find/find_ctr.dart';
import 'package:fun_reader/pages/find/phone/find_phone_item.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 16:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class FindPhonePage extends GetView<FindCtr>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: Text(Keys.find.tr),
        actions: [
          // 搜索
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                SearchPage.go();
              }),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () {
            return controller.queryAllRule();
          },
          child: Obx(() => ListView.builder(
            itemCount: controller.rulelist.length,
            itemBuilder: (BuildContext context, int index) {
              return FindPhoneItem(
                ruleBean: controller.rulelist[index].ruleBean!,
              );
            },
          )),
        ),
      ),
    );
  }
}


