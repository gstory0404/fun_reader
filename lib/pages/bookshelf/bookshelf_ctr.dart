import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/manager/db_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:06
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookShelfCtr extends GetxController{
  DBManager dbManager = DBManager();
  //分类书籍列表
  var bookList = <BookDetailBean>[].obs;


  @override
  void onReady() {
    super.onReady();
    getAllBook();
  }

  Future<void> getAllBook()  async {
    bookList.value = await dbManager.queryAllBooks();
  }
}

