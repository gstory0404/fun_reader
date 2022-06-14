import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fun_novel/entity/chapter_bean.dart';
import 'package:fun_novel/pages/book/book_ctr.dart';
import 'package:fun_novel/pages/chapter/chapter_page.dart';
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
        title: Obx(() => Text(controller.bookName.value)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 14, left: 20, right: 20),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                            () =>
                        controller.cover.value.isEmpty
                            ? Image.asset(
                          "assets/images/icon_book_logo.png",
                          width: 90,
                          height: 120,
                          fit: BoxFit.fill,
                        )
                            : Image.network(
                          controller.cover.value,
                          width: 90,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() =>
                                  Text(
                                    controller.bookName.value,
                                    style: TextStyle(fontSize: 16),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Obx(() =>
                                    Text(
                                      controller.author.value,
                                      style: TextStyle(fontSize: 14),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  alignment: WrapAlignment.start,
                                  children: controller.category
                                      .map((element) =>
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          //设置四周边框
                                          border: Border.all(
                                              width: 1, color: Colors.black45),
                                        ),
                                        child: Text(
                                          element ?? "",
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                      .toList(),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                child: Obx(() =>
                                    Text(
                                      controller.updateTime.value,
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
                    child: Obx(() => Text(controller.intro.value)),
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
                        if(controller.chapterList.isEmpty){
                          EasyLoading.showToast('获取章节列表失败');
                          return;
                        }
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return ChapterPage(
                                sourceUrl: controller.sourceUrl,
                                chapterList: controller.chapterList,
                              );
                            });
                      },
                      child: Row(
                        children: [
                          const Text("最新"),
                          Expanded(
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 16),
                              child: Obx(() =>
                                  Text(
                                    controller.lastChapter.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                          ),
                          Image.asset(
                            "assets/images/icon_right.png",
                            width: 16,
                            height: 16,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text(
                    "加入书架",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                Container(
                  width: 1,
                  color: Colors.white,
                ),
                InkWell(
                  onTap: () {

                  },
                  child: const Text(
                    "立即阅读",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
