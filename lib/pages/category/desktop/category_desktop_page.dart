import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/category/category_ctr.dart';
import 'package:fun_reader/widgets/book_item.dart';
import 'package:fun_reader/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 18:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class CategoryDesktopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: GetBuilder<CategoryCtr>(
          builder: (controller) {
            return Text(controller.name);
          },
        ),
      ),
      body: GetBuilder<CategoryCtr>(
        builder: (controller) {
          return  StatusWidget(
            loadType: controller.loadStatus,
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: controller.booksController,
                      itemCount: controller.categoryBookList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BookItem(
                            sourceUrl: controller.sourceUrl,
                            bookBean: controller.categoryBookList[index]);
                      },
                    ),
                  ),
                  controller.isLoading
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
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
