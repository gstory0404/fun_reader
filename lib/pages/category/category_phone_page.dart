import 'package:flutter/material.dart';
import 'package:fun_novel/pages/category/category_ctr.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
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
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                            BorderSide(width: 1, color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          children: [
                            controller.categoryBookList[index].logo.isEmpty
                                ? Image.asset(
                              "assets/images/icon_book_logo.png",
                              width: 80,
                              height: 100,
                              fit: BoxFit.fill,
                            )
                                : Image.network(
                              controller.categoryBookList[index].logo,
                              width: 80,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.categoryBookList[index].title
                                          .replaceAll(" ", ""),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller
                                          .categoryBookList[index].author,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller
                                          .categoryBookList[index].content,
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
