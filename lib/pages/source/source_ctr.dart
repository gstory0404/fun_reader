import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/find/find_ctr.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 10:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SourceCtr extends GetxController {
  MyConnect connect = Get.find();
  var rulelist = <DBRuleBean>[].obs;

  @override
  void onInit() {
    super.onInit();
    queryAllRule();
  }

  ///获取所有书源
  void queryAllRule() async {
    rulelist.value = await RuleDao().queryAll();
  }

  ///修改书源 启动状态
  void changeEffect(int index, bool isEffect) {
    rulelist[index].isEffect = isEffect;
    RuleDao().update(rulelist[index]);
    rulelist.refresh();
  }

  ///删除书源
  void deleteRule(DBRuleBean bean) {
    RuleDao().delete(bean);
    queryAllRule();
  }

  ///下载文件
  Future<void> download(String url) async {
    ToastUtil.showLoading("");
    Directory tempDir = await getTemporaryDirectory();
    var filePath = "${tempDir.path}/rule/${DateUtil.nowTimestamp()}.json";
    var response = await Dio()
        .download(url, filePath, onReceiveProgress: (received, total) {
      print("下载进度$received/$total");
      if(received == total){
        ToastUtil.dismiss();
        readFile(filePath);
      }
    });
  }

  ///选择文件
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'json'],
    );
    if (result != null && result.files.single.path != null) {
      if(result.files.single.path!.endsWith(".txt") || result.files.single.path!.endsWith(".json")){
        readFile(result.files.single.path!);
      }
    } else {
      ToastUtil.showToast(Keys.sourceFileError.tr);
    }
  }

  ///读取文件
  Future<void> readFile(String path) async {
    var file = File(path);
    final contents = await file.readAsString();
    List list = json.decode(contents);
    for (var element in list) {
      RuleBean bean = RuleBean.fromJson(element);
      print("保存${bean.toJson()}");
      var dbBean = await RuleDao().query(bean.sourceUrl ?? "");
      //如果不存在就插入表中
      if(dbBean?.id == null){
        DBRuleBean dbRuleBean = DBRuleBean();
        dbRuleBean.sourceUrl = bean.sourceUrl;
        dbRuleBean.sourceName = bean.sourceName;
        dbRuleBean.ruleBean = bean;
        dbRuleBean.isEffect = true;
        print("保存${dbRuleBean.toJson()}");
        RuleDao().insert(dbRuleBean);
      }
    }
    //刷新数据
    queryAllRule();
    //发现页
    FindCtr findCtr = Get.find();
    findCtr.queryAllRule();
    //搜索页
    SearchCtr searchCtr = Get.find();
    searchCtr.queryAllRule();
    ToastUtil.showToast(Keys.addSourceSuccess.tr);
  }
}
