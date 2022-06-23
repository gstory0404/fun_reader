import 'package:flutter/material.dart';
import 'package:fun_reader/pages/chapter/chapter_page.dart';
import 'package:fun_reader/pages/read/phone/read_phone_menu.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:fun_reader/pages/read/phone/read_phone_item.dart';
import 'package:fun_reader/pages/widgets/status_widget.dart';
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
        body: Obx(() => StatusWidget(loadType: controller.loadStatus.value, body: Stack(
          children: [
            Obx(() => Container(
              color: controller.readPhoneCtr
                  .bgColorList[controller.readPhoneCtr.bgColor.value],
              child: Column(
                children: [
                  Container(
                    margin:
                    EdgeInsets.only(top: context.mediaQueryPadding.top),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    child: Row(
                      children: [
                        Obx(() => Text(
                          controller.book.value.chapterList.isNotEmpty
                              ? controller
                              .book
                              .value
                              .chapterList[
                          controller.chapterIndex.value]
                              .chapterName ??
                              ""
                              : "",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily:
                            controller.readPhoneCtr.fontFamilyList[
                            controller
                                .readPhoneCtr.fontFamily.value],
                            color:
                            controller.readPhoneCtr.fontColorList[
                            controller
                                .readPhoneCtr.fontColor.value],
                          ),
                        )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Obx(
                            () => ScrollablePositionedList.builder(
                          itemCount: controller.chapterContentList.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => ReadPhoneItem(
                            chapter: controller.chapterContentList[index],
                          ),
                          itemScrollController:
                          controller.readScrollController,
                          itemPositionsListener:
                          controller.readPositionsListener,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: controller.readPhoneCtr.widthMarginList[
                        controller.readPhoneCtr.widthMargin.value],
                        vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text(
                          "《${controller.book.value.bookName}》",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily:
                            controller.readPhoneCtr.fontFamilyList[
                            controller
                                .readPhoneCtr.fontFamily.value],
                            color:
                            controller.readPhoneCtr.fontColorList[
                            controller
                                .readPhoneCtr.fontColor.value],
                          ),
                        )),
                        Obx(() => Text(
                          "${controller.chapterIndex.value + 1} / ${controller.book.value.chapterList.length}",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily:
                            controller.readPhoneCtr.fontFamilyList[
                            controller
                                .readPhoneCtr.fontFamily.value],
                            color:
                            controller.readPhoneCtr.fontColorList[
                            controller
                                .readPhoneCtr.fontColor.value],
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
            )),
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
        ))));
  }
}
