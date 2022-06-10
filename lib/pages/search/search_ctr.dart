import 'package:fun_novel/entity/search_book_entity.dart';
import 'package:fun_novel/pages/search/search_connect.dart';
import 'package:get/get.dart';
import 'package:xpath_selector/xpath_selector.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 16:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchCtr extends GetxController {
  SearchConnect connect;

  //分类书籍列表
  var bookList = <SearchBookEntity>[].obs;

  SearchCtr({required this.connect});

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<List<SearchBookEntity>> searchBook(String key) async {
    var html =
        await connect.searchBook("/search.php?searchkey=", key);
    var books = XPath.html(html).query("//*[@class=\"hot_sale\"]").nodes;
    bookList.clear();
    //书籍
    for (var element in books) {
      var title = element
          .queryXPath(connect.spiderManager.spiderBean!.search!.bookName!)
          .attr;
      var author = element
          .queryXPath(connect.spiderManager.spiderBean!.search!.author!)
          .attr;
      var content = element
          .queryXPath(connect.spiderManager.spiderBean!.search!.content!)
          .attr;
      var logo = element
          .queryXPath(connect.spiderManager.spiderBean!.search!.logo!)
          .attr;
      var id = element
          .queryXPath(connect.spiderManager.spiderBean!.search!.id!)
          .attr;
      bookList.add(SearchBookEntity(
          title: title
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          author: author
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          content: content
              ?.replaceAll(" ", "")
              .replaceAll("\n", "")
              .replaceAll("\r;", "") ??
              "",
          logo: logo ?? "",
          id: id ?? ""));
    }
    return bookList;
  }
}
