import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_reader/pages/search/phone/search_phone_appbar.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/pages/widgets/book_item.dart';
import 'package:fun_reader/pages/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 11:38
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPhonePage extends GetView<SearchCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPhoneAppbar(),
      body: Container(
        child: Obx(
          () => StatusWidget(loadType: controller.loadStatus.value, body: ListView.builder(
            itemCount: controller.bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return BookItem(
                sourceUrl: controller.rule.value.sourceUrl!,
                bookBean: controller.bookList[index],
              );
            },
          )),
        ),
      ),
    );
  }
}
