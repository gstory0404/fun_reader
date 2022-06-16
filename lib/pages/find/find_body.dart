import 'package:flutter/material.dart';
import 'package:fun_reader/pages/find/find_ctr.dart';
import 'package:fun_reader/pages/find/find_item.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:48
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FindBody extends GetView<FindCtr> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: controller.rulelist.length,
          itemBuilder: (BuildContext context, int index) {
            return FindItem(
              ruleBean: controller.rulelist[index],
            );
          },
        ));
  }
}
