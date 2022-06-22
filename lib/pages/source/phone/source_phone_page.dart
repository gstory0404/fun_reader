import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/source/source_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 10:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SourcePhonePage extends GetView<SourceCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Keys.bookSourceManage.tr),
      ),
      body: Container(
        child: Obx(() => ListView.builder(
            itemCount: controller.rulelist.length,
            itemBuilder: (context, index) {
              return _sourceItem(context, index, controller.rulelist[index]);
            })),
      ),
    );
  }

  _sourceItem(BuildContext context, int index, DBRuleBean bean) {
    return InkWell(
      onTap: () {
        Get.dialog(
          Scaffold(
            appBar: AppBar(
              title: Text(bean.sourceName ?? ""),
            ),
            body: ListView(
              children: [
                Text(
                  bean.rule ?? "",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                )
              ],
            ),
          ),
          useSafeArea: true,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(child: Text(bean.sourceName ?? "")),
            Switch(
                value: bean.isEffect,
                onChanged: (value) {
                  controller.changeEffect(index, value);
                }),
            IconButton(
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(Keys.deleteSource.tr),
                          content: Text(Keys.deleteSourceTips.tr),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(Keys.cancel.tr)),
                            TextButton(
                              onPressed: () {
                                controller.deleteRule(bean);
                                Get.back();
                              },
                              child: Text(Keys.delete.tr),
                            )
                          ],
                        );
                      });
                },
                icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
          ],
        ),
      ),
    );
  }
}
