import 'package:flutter/material.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends BaseWidget<IndexCtr> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text("FunNovel"),
    );
  }

  @override
  Widget desktopBody() {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Obx(() => ListView.builder(
                itemCount: controller.categoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(controller.categoryList[index].name);
                },
              )),
          Container(
            height: 300,
            child: Obx(() => ListView.builder(
                  itemExtent: 1.2,
                  itemCount: controller.categoryBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(controller.categoryBookList[index].title);
                  },
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget phoneBody() {
    return Container(
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
                            child: Text(controller.categoryList[index].name),
                          )),
                      onTap: () {
                        controller.chooseIndex.value = index;
                        controller.getCategoryData(
                            controller.categoryList[index].id,
                            isNew: true);
                      },
                    );
                  },
                )),
          ),
          Expanded(
            flex: 4,
            child: Obx(() => ListView.builder(
                  itemCount: controller.categoryBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(controller.categoryBookList[index].title);
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black12))),
                        child: Row(
                          children: [
                            Image.network(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.categoryBookList[index].title
                                          .replaceAll(" ", ""),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller.categoryBookList[index].author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller
                                          .categoryBookList[index].content,
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
          )
        ],
      ),
    );
  }
}
