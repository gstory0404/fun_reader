import 'package:flutter/material.dart';
import 'package:fun_novel/pages/category/category_ctr.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:fun_novel/pages/widgets/book_item.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryPhonePage extends GetWidget<CategoryCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Obx(() => ListView.builder(
                itemCount: controller.categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Obx(() => Container(
                      alignment: Alignment.center,
                      color: controller.chooseIndex.value == index
                          ? Colors.black12
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        controller.categoryList[index].name,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )),
                    onTap: () {
                      controller.chooseIndex.value = index;
                      controller
                          .getCategoryData(controller.categoryList[index].id);
                    },
                  );
                },
              )),
            ),
            Expanded(
              flex: 4,
              child: RefreshIndicator(
                onRefresh: () {
                  return controller.getCategoryData(
                      controller.categoryList[controller.chooseIndex.value].id);
                },
                child: Obx(() => ListView.builder(
                  controller: controller.booksController,
                  itemCount: controller.categoryBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookItem(bookBean: controller.categoryBookList[index]);
                  },
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
