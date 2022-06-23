import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/category/category_ctr.dart';
import 'package:fun_reader/pages/widgets/book_item.dart';
import 'package:fun_reader/pages/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryPhonePage extends GetView<CategoryCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: Obx(() => Text(controller.name.value)),
      ),
      body: Obx(() => StatusWidget(loadType: controller.loadStatus.value, body: Container(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.loadMore();
                },
                child: Obx(() => ListView.builder(
                  controller: controller.booksController,
                  itemCount: controller.categoryBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookItem(
                        sourceUrl: controller.sourceUrl,
                        bookBean: controller.categoryBookList[index]);
                  },
                )),
              ),
            ),
            Obx(() => controller.isLoading.value
                ? Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.only(right: 10),
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  Text(
                    Keys.loadMore.tr,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            )
                : Container()),
          ],
        ),
      ))),
    );
  }
}
