import 'package:fun_novel/manager/my_connect.dart';
import 'package:fun_novel/pages/book/book_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadCtr extends GetxController{
  MyConnect connect = Get.find();
  BookCtr? bookCtr  = Get.find();

  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0;

  var index = 0;

  ReadCtr();

  @override
  void onReady() {
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    chapterIndex = Get.arguments["chapterIndex"];
    bookCtr ??= Get.put(BookCtr());
  }


  // Future<String> getChapterContent(String path) async {
  //   var html = await connect.getBookChapterConnect(path);
  //   var chapters =  XPath.html(html)
  //       .query(connect.spiderManager.spiderBean!.chapter!.chapters!)
  //       .nodes;
  // }
}


