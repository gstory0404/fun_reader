import 'package:flutter/material.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/index/index_ctr.dart';
import 'package:fun_novel/pages/index/index_phone_body.dart';
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
    return IndexPhoneBody();
  }
}
