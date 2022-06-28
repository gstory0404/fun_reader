import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/find/desktop/find_desktop_item.dart';
import 'package:fun_reader/pages/find/find_ctr.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:fun_reader/pages/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 16:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class FindDesktopPage extends GetView<FindCtr>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(Keys.find.tr,style: const TextStyle(fontSize: 24,color: Colors.black),),
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh,color: Colors.black,),
              onPressed: () {
                controller.queryAllRule();
              }),
        ],
      ),
      body: Obx(() => StatusWidget(loadType: controller.loadStatus.value, body: Container(
        child: RefreshIndicator(
          onRefresh: () {
            return controller.queryAllRule();
          },
          child: Obx(() => ListView.builder(
            itemCount: controller.rulelist.length,
            itemBuilder: (BuildContext context, int index) {
              return FindDesktopItem(
                ruleBean: controller.rulelist[index].ruleBean!,
              );
            },
          )),
        ),
      ))),
    );
  }
}


