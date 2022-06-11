import 'package:fun_novel/manager/spider_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookConnect extends GetConnect{

  SpiderManager spiderManager = SpiderManager();

  @override
  void onInit() {

  }

  //获取书籍详情
  Future<String> getBookDetail(String path) async{
    if(!path.startsWith("http")){
      httpClient.baseUrl = spiderManager.spiderBean?.url;
    }
    Response<String> response = await get(path);
    return response.body ?? "";
  }

  //获取章节列表
  Future<String> getBookChapterList(String path) async{
    if(!path.startsWith("http")){
      httpClient.baseUrl = spiderManager.spiderBean?.url;
    }
    Response<String> response = await get(path);
    return response.body ?? "";
  }
}


