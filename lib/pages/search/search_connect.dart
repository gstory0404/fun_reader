import 'package:fun_novel/manager/spider_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class SearchConnect extends GetConnect{

  SpiderManager spiderManager = SpiderManager();


  Future<String> searchBook(String path,String searchKey,{String postKey = ""}) async{
    httpClient.baseUrl = spiderManager.spiderBean?.url;
    Response<String> response;
    if(postKey.isEmpty){
      response = await get("$path$searchKey");
    }else{
      response = await post(path,{postKey:searchKey},headers: {"content-type":"application/x-www-form-urlencoded"});
    }
    return response.body ?? "";
  }

}


