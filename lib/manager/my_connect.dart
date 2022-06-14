import 'dart:convert';

import 'package:fun_novel/manager/spider_manager.dart';
import 'package:fun_novel/utils/log_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 15:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MyConnect extends GetConnect {
  SpiderManager spiderManager = SpiderManager();

  @override
  void onInit() {}

  Future<String> getData(String sourceUrl, String path,
      {Map<String, dynamic>? query}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    Map<String, String>? head;
    if (spiderManager.getRule(sourceUrl).head?.isNotEmpty ?? false) {
      head = json.decode(spiderManager.getRule(sourceUrl).head!);
    }
    Response<String> response = await get(path, query: query, headers: head);
    return response.body ?? "";
  }

  Future<String> postData(
      String sourceUrl, String path, Map<String, dynamic>? body,
      {String? contentType}) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = sourceUrl;
    } else {
      httpClient.baseUrl = "";
    }
    Map<String, String>? head = {};
    if (spiderManager.getRule(sourceUrl).head?.isNotEmpty ?? false) {
      head = json.decode(spiderManager.getRule(sourceUrl).head!);
    }
    Response<String> response =
        await post(path, body, headers: head, contentType: contentType);
    return response.body ?? "";
  }
}
