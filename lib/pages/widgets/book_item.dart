import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 11:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class BookItem extends StatelessWidget {
  BookBean bookBean;

  BookItem({Key? key, required this.bookBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.BOOK, arguments: {"bookId": bookBean.id});
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
            bookBean.logo.isEmpty
                ? Image.asset(
                    "assets/images/icon_book_logo.png",
                    width: 80,
                    height: 100,
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    bookBean.logo,
                    width: 80,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookBean.title.replaceAll(" ", ""),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bookBean.author,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bookBean.content,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
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
