import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/book/book_ctr.dart';
import 'package:fun_reader/pages/chapter/chapter_page.dart';
import 'package:fun_reader/pages/read/read_page.dart';
import 'package:fun_reader/pages/widgets/book_cover_widget.dart';
import 'package:fun_reader/pages/widgets/status_widget.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:35
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookPhonePage extends GetView<BookCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: Obx(() => Text(controller.book.value.bookName ?? "")),
      ),
      backgroundColor: Colors.white,
      body: Obx(() => StatusWidget(
        loadType: controller.loadStatus.value,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 14, left: 20, right: 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                                  () => BookCoverWidget(
                                  controller.book.value.cover ?? "",
                                  width: 90,
                                  height: 120),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Obx(() => Text(
                                      controller.book.value.bookName ?? "",
                                      style: TextStyle(fontSize: 16),
                                    )),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: Obx(() => Text(
                                        controller.book.value.author ?? "",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: Wrap(
                                        spacing: 8.0,
                                        runSpacing: 4.0,
                                        alignment: WrapAlignment.start,
                                        children: controller.book.value.category
                                            .map((element) => Container(
                                          margin: const EdgeInsets.only(
                                              top: 4),
                                          padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(5),
                                            //设置四周边框
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.black45),
                                          ),
                                          child: Text(
                                            element?.trim() ?? "",
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ))
                                            .toList(),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Obx(() => Text(
                                        controller.book.value.updateTime ??
                                            "",
                                        style: TextStyle(fontSize: 14),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child:
                          Obx(() => Text(controller.book.value.intro ?? "")),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Color(0xffe5e5e5),
                              ),
                              bottom: BorderSide(
                                width: 1,
                                color: Color(0xffe5e5e5),
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () async {
                              if (controller.book.value.chapterList.isEmpty) {
                                ToastUtil.showToast(Keys.getChapterError.tr);
                                return;
                              }
                              Get.bottomSheet(
                                  ChapterPage(
                                    chapterList:
                                    controller.book.value.chapterList,
                                    onChoose: (index) {
                                      ReadPage.go(
                                          sourceUrl: controller.sourceUrl,
                                          bookUrl: controller.bookUrl,
                                          chapterIndex: index);
                                    },
                                  ),
                                  isScrollControlled: true);
                            },
                            child: Row(
                              children: [
                                Text(Keys.newest.tr),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Obx(() => Text(
                                      controller.book.value.lastChapter ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ),
                                ),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        controller.addBookShelf();
                      },
                      child: Obx(
                            () => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: controller.book.value.isBookshelf
                                ? Colors.grey
                                : Color(0xFF12aa9c),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25)),
                          ),
                          child: Text(
                            controller.book.value.isBookshelf
                                ? Keys.hasBookshelf.tr
                                : Keys.addBookshelf.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (controller.book.value.chapterList.isEmpty) {
                          ToastUtil.showToast(Keys.noChapter.tr);
                          return;
                        }
                        ReadPage.go(
                            sourceUrl: controller.sourceUrl,
                            bookUrl: controller.bookUrl,
                            chapterIndex: 0);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color(0xFF12aa9c),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: Text(
                          Keys.read.tr,
                          style:
                          const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
