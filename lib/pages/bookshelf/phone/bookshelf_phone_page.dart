import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_ctr.dart';
import 'package:fun_reader/pages/bookshelf/phone/bookshelf_phone_sheet.dart';
import 'package:fun_reader/pages/read/read_page.dart';
import 'package:fun_reader/pages/search/search_page.dart';
import 'package:fun_reader/pages/widgets/book_cover_widget.dart';
import 'package:fun_reader/utils/date_util.dart';
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
      appBar: AppBar(
        backgroundColor: Color(0xFF12aa9c),
        title: Text(Keys.bookshelf.tr),
        actions: [
          // 搜索
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                SearchPage.go();
              }),
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: () {
            return ctr.getAllBooks();
          },
          child: Obx(() => ListView.builder(
                itemCount: ctr.bookList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listItem(context, ctr.bookList[index]);
                },
              )),
        ),
      ),
    );
  }

  _listItem(BuildContext context, BookDetailBean bookBean) {
    return InkWell(
      onTap: () {
        ReadPage.go(
            sourceUrl: bookBean.sourceUrl ?? "",
            bookUrl: bookBean.bookUrl ?? "",
            chapterIndex: bookBean.lastReadIndex);
      },
      onLongPress: () {
        Get.bottomSheet(BookShelfPhoneSheet(
          book: bookBean,
        ));
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Row(
          children: [
            BookCoverWidget(bookBean.cover ?? "", width: 80, height: 100),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      "${Keys.lastRead.tr}：${bookBean.lastReadChapter}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${Keys.latestChapter.tr}：${bookBean.lastChapter}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${Keys.lastReadTime.tr}：${DateUtil.getDateScope(checkDate: bookBean.lastReadTime)}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${Keys.bookSource.tr}：《${bookBean.sourceName}》",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 1,
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
