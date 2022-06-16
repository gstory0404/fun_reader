import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookCtr extends GetxController {
  MyConnect connect = Get.find();
  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0;
  RuleBean? rule;

  //书籍相关参数
  var book = BookDetailBean().obs;

  BookCtr({this.sourceUrl = "", this.bookUrl = ""});

  @override
  Future<void> onReady() async {
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    //解析规则
    rule = connect.spiderManager.getRule(sourceUrl);
    //获取书籍
    if (rule != null && sourceUrl.isNotEmpty && bookUrl.isNotEmpty) {
      book.value = await connect.getBookDetail(rule!, bookUrl);
    }
  }
}
