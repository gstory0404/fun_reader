import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_ctr.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookCtr extends BaseCtr {
  MyConnect connect = Get.find();
  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0;
  RuleBean? rule;

  //书籍相关参数
  var book = BookDetailBean();

  @override
  Future<void> onReady() async {
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    //解析规则
    rule = (await RuleDao().query(sourceUrl))?.ruleBean;
    //获取书籍
    if (rule != null && sourceUrl.isNotEmpty && bookUrl.isNotEmpty) {
      showLoading();
      book = await connect.getBookDetail(rule!, bookUrl);
      showMain();
    }else{
      showError();
    }
    update();
  }

  //添加书架
  Future<void> addBookShelf() async {
    ToastUtil.showLoading("正在加载...");
    if (book.id != null) {
      book = await BookDao().update(book
        ..isBookshelf = !book.isBookshelf
        ..addTime = DateUtil.nowTimestamp());
    } else {
      book = await BookDao().insert(book
        ..isBookshelf = true
        ..addTime = DateUtil.nowTimestamp());
    }
    update();
    //刷新书架
    BookShelfCtr bookShelfCtr = Get.find();
    bookShelfCtr.getAllBooks();
    ToastUtil.dismiss();
  }
}
