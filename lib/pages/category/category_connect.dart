import 'package:fun_reader/manager/spider_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/8 14:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class CategoryConnect extends GetConnect{

  SpiderManager spiderManager = SpiderManager();

  @override
  void onInit() {

  }

  Future<String> getData(String path) async{
    if(!path.startsWith("http")){
      httpClient.baseUrl = spiderManager.spiderBean?.url;
    }
    Response<String> response = await get(path);
    return response.body ?? "";
  }
}


