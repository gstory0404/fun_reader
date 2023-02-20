import 'package:flutter/material.dart';
import 'package:fun_reader/pages/chapter/chapter_page.dart';
import 'package:fun_reader/pages/comic/comic_ctr.dart';
import 'package:fun_reader/pages/comic/phone/comic_phone_item.dart';
import 'package:fun_reader/pages/comic/phone/comic_phone_menu.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/10/21 12:10
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ComicPhonePage extends StatefulWidget {
  const ComicPhonePage({Key? key}) : super(key: key);

  @override
  State<ComicPhonePage> createState() => _ComicPhonePageState();
}

class _ComicPhonePageState extends State<ComicPhonePage> {
  ComicCtr controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: context.width * 0.8,
        child: GetBuilder<ComicCtr>(
          builder: (controller) {
            return ChapterPage(
              chapterList: controller.book.chapterList,
              index: controller.chapterIndex,
              onChoose: (index) {
                controller.chapterIndex = index;
                controller.reloadChapter();
                //关闭draw
                Get.back();
                controller.isShowMenu.value = false;
              },
            );
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          controller.isShowMenu.value = !controller.isShowMenu.value;
        },
        child: Stack(
          children: [
            GetBuilder<ComicCtr>(
              builder: (controller) {
                return Container(
                  alignment: Alignment.center,
                  child: ScrollablePositionedList.builder(
                    itemCount: controller.chapterContentList.length,
                    itemScrollController: controller.readScrollController,
                    itemPositionsListener: controller.readPositionsListener,
                    itemBuilder: (context, index) {
                      return ComicPhoneItem(
                        content: controller.chapterContentList[index],
                      );
                    },
                  ),
                );
              },
            ),
            Builder(
              builder: (BuildContext context) {
                return controller.isShowMenu.value
                    ? ComicPhoneMenu(
                        openDraw: () {
                          Scaffold.of(context).openDrawer();
                        },
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
