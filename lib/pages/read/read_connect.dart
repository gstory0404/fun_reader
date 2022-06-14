import 'package:fun_novel/manager/spider_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadConnect extends GetConnect {
  SpiderManager spiderManager = SpiderManager();

  //获取章节列表
  Future<String> getBookChapterConnect(String path) async {
    if (!path.startsWith("http")) {
      httpClient.baseUrl = spiderManager.spiderBean?.url;
    }
    Response<String> response = await get(path);
    return response.body ?? "";
  }
}
