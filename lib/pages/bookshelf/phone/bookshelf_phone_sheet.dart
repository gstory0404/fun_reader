import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/book/book_page.dart';
import 'package:fun_reader/pages/bookshelf/bookshelf_ctr.dart';
import 'package:fun_reader/pages/read/read_page.dart';
import 'package:fun_reader/pages/widgets/book_cover_widget.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 10:49
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookShelfPhoneSheet extends GetView<BookShelfCtr> {
  BookDetailBean book;

  BookShelfPhoneSheet({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookCoverWidget(book.cover ?? "", width: 80, height: 100),
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
                          book.bookName ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${Keys.lastRead.tr}：${book.lastReadChapter}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${Keys.latestChapter.tr}：${book.lastChapter}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${Keys.lastReadTime.tr}：${DateUtil.getDateScope(checkDate: book.lastReadTime)}",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${Keys.bookSource.tr}《${book.sourceName}》",
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
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      ReadPage.go(
                          sourceUrl: book.sourceUrl ?? "",
                          bookUrl: book.bookUrl ?? "",
                          chapterIndex: book.lastReadIndex);
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 1, color: Colors.black87),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.book, size: 20),
                          Text(
                            Keys.read.tr,
                            style:
                            const TextStyle(fontSize: 14, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      BookPage.go(
                          sourceUrl: book.sourceUrl ?? "",
                          bookUrl: book.bookUrl ?? "");
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 1, color: Colors.black87),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.bookmarks, size: 20),
                          Text(
                            Keys.detail.tr,
                            style:
                                const TextStyle(fontSize: 14, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      controller.deleteBookShelf(book);
                      Get.back();
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 1, color: Colors.black87),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_rounded, size: 20),
                          Text(
                            Keys.delete.tr,
                            style:
                                const TextStyle(fontSize: 14, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: Text(
                book.intro ?? "",
                style: const TextStyle(
                  fontSize: 13,
                ),
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
