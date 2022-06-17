import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/pages/book/book_ctr.dart';
import 'package:fun_reader/pages/book/book_page.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_ctr.dart';
import 'package:fun_reader/pages/widgets/book_cover_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/17 18:10
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookShelfPhonePage extends GetView<BookShelfCtr> {

  BookShelfCtr ctr = Get.put(BookShelfCtr());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: RefreshIndicator(
          onRefresh: () {
            return ctr.getAllBook();
          },
          child: Obx(() => ListView.builder(
                itemCount: ctr.bookList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listItem(ctr.bookList[index]);
                },
              )),
        ),
      ),
    );
  }

  _listItem(BookDetailBean bookBean){
    InkWell(
      onTap: () {
        BookPage.go(
            sourceUrl: bookBean.sourceUrl ?? "",
            bookUrl: bookBean.bookUrl!);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Row(
          children: [
            BookCoverWidget(bookBean.cover ?? "",
                width: 80, height: 100),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookBean.bookName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bookBean.author ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bookBean.intro ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
