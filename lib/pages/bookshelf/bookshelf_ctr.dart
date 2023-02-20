import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:06
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookShelfCtr extends BaseCtr{
  //分类书籍列表
  var bookList = <BookDetailBean>[];


  @override
  void onReady() {
    super.onReady();
    getAllBooks();
  }

  //获取全部书籍
  Future<void> getAllBooks()  async {
    showLoading();
    bookList = await BookDao().queryAllBookShelf();
    if(bookList.isEmpty){
      showEmpty();
    }else{
      showMain();
    }
    update();
  }

  //移出书架
  void deleteBookShelf(BookDetailBean bean) async{
    bean.isBookshelf = false;
    await BookDao().update(bean);
    await getAllBooks();
  }

}

