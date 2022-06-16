import 'package:flutter/material.dart';
import 'package:fun_novel/pages/chapter/chapter_page.dart';
import 'package:fun_novel/pages/read/phone/read_phone_menu.dart';
import 'package:fun_novel/pages/read/read_ctr.dart';
import 'package:fun_novel/pages/widgets/read/read_item.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:49
/// @Email gstory0404@gmail.com
/// @Description: 手机阅读页

class ReadPhonePage extends StatefulWidget {
  const ReadPhonePage({Key? key}) : super(key: key);

  @override
  State<ReadPhonePage> createState() => _ReadPhonePageState();
}

class _ReadPhonePageState extends State<ReadPhonePage> {
  ReadCtr controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
//
// class ReadPhonePage extends GetView<ReadCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          width: context.width * 0.8,
          child: Obx(
            () => ChapterPage(
              chapterList: controller.book.value.chapterList,
              index: controller.chapterIndex.value,
              onChoose: (index) {
                controller.chapterIndex.value = index;
                controller.reloadChapter();
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: context.mediaQueryPadding.top),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Row(
                      children: [
                        Obx(() => Text(controller
                                .book.value.chapterList.isNotEmpty
                            ? controller
                                    .book
                                    .value
                                    .chapterList[controller.chapterIndex.value]
                                    .chapterName ??
                                ""
                            : "")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Obx(
                        () => ScrollablePositionedList.builder(
                          itemCount: controller.chapterContentList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ReadItem(
                            chapter: controller.chapterContentList[index],
                          ),
                          itemScrollController: controller.readScrollController,
                          itemPositionsListener:
                              controller.readPositionsListener,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text("《${controller.book.value.bookName}》")),
                        Obx(() => Text(
                            "${controller.chapterIndex.value + 1} / ${controller.book.value.chapterList.length}")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return Obx(() => controller.isShowMenu.value
                    ? ReadPhoneMenu(
                        openDraw: () {
                          Scaffold.of(context).openDrawer();
                        },
                      )
                    : Container());
              },
            ),
          ],
        ));
  }
}
