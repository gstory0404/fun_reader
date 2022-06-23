import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/source/source_ctr.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 16:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class SourceDesktopPage extends GetView<SourceCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: Text(Keys.bookSourceManage.tr),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              _selectView(Icons.file_download, Keys.netFile.tr, 'net'),
              _selectView(
                  Icons.drive_file_move_sharp, Keys.localFile.tr, 'file'),
            ],
            onSelected: (String action) {
              switch (action) {
                case 'net':
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        final editontroller = TextEditingController();
                        return CupertinoAlertDialog(
                          title: Text(Keys.netFile.tr),
                          content: Card(
                            elevation: 0.0,
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: editontroller,
                                  decoration: InputDecoration(
                                    hintText: Keys.netFileHint.tr,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(Keys.cancel.tr)),
                            TextButton(
                              onPressed: () {
                                var text = editontroller.text;
                                if (text.startsWith("http") &&
                                    (text.endsWith(".txt") ||
                                        text.endsWith(".json"))) {
                                  Get.back();
                                  controller.download(text);
                                } else {
                                  ToastUtil.showToast(Keys.netFileHint.tr);
                                }
                              },
                              child: Text(Keys.confirm.tr),
                            )
                          ],
                        );
                      });
                  break;
                case 'file':
                  controller.selectFile();
                  break;
              }
            },
          ),
        ],
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

  // 菜单item
  _selectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Colors.blue),
            Text(text),
          ],
        ));
  }

  _sourceItem(BuildContext context, int index, DBRuleBean bean) {
    return InkWell(
      onTap: () {
        Get.dialog(
          Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF12aa9c),
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

