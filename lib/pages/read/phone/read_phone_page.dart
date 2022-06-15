import 'package:flutter/material.dart';
import 'package:fun_novel/pages/read/read_ctr.dart';
import 'package:fun_novel/pages/widgets/read/read_item.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:49
/// @Email gstory0404@gmail.com
/// @Description: 手机阅读页

class ReadPhonePage extends GetView<ReadCtr> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Obx(
                () => ScrollablePositionedList.builder(
                  itemCount: controller.chapterContentList.length,
                  itemBuilder: (context, index) => ReadItem(
                    chapter: controller.chapterContentList[index],
                  ),
                  itemScrollController: controller.readScrollController,
                  itemPositionsListener: controller.readPositionsListener,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: [
                Obx(() => Text(controller.book.value.bookName)),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
