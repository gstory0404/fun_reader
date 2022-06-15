import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/pages/book/book_page.dart';
import 'package:fun_novel/pages/widgets/book_cover_widget.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookItem extends StatelessWidget {
  String sourceUrl;
  BookBean bookBean;

  BookItem({Key? key, required this.sourceUrl, required this.bookBean})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BookPage.go(sourceUrl: sourceUrl, bookUrl: bookBean.bookUrl!);
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
            BookCoverWidget(bookBean.cover ?? "",width:80,height:100),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookBean.name ?? "",
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
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      alignment: WrapAlignment.start,
                      children: bookBean.category
                              ?.map((e) => Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      //设置四周边框
                                      border: Border.all(
                                          width: 1, color: Colors.black45),
                                    ),
                                    child: Text(
                                      e ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList() ??
                          [],
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
