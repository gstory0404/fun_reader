import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/manager/db_manager.dart';
import 'package:fun_reader/utils/log_util.dart';
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
    getAllBooks();
  }

  //获取全部书籍
  Future<void> getAllBooks()  async {
    bookList.value = await dbManager.queryAllBookShelf();
    LogUtil.d(bookList.length);
  }

  //移出书架
  void deleteBookShelf(BookDetailBean bean) async{
    bean.isBookshelf = false;
    await dbManager.updateBook(bean);
    await getAllBooks();
  }

}

