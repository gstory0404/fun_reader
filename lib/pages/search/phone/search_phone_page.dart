import 'package:flutter/material.dart';
import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/search_bean.dart';
import 'package:fun_reader/pages/search/phone/search_phone_appbar.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/widgets/book_item.dart';
import 'package:fun_reader/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 11:38
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchPhoneAppbar(),
      body: GetBuilder<SearchCtr>(
        builder: (controller) {
          return StatusWidget(
            loadType: controller.loadStatus,
            body: ListView.builder(
              itemCount: controller.searchBooks.length,
              itemBuilder: (BuildContext context, int index) {
                return _books(controller.searchBooks[index]);
              },
            ),
          );
        },
      ),
    );
  }

  _books(SearchBean searchBean) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: searchBean.books?.length,
      itemBuilder: (BuildContext context, int index) {
        // print("${searchBean?.rule?.sourceUrl}${searchBean.books![index].bookUrl}");
        return BookItem(
          sourceUrl: searchBean.rule?.sourceUrl ?? "",
          bookBean: searchBean.books![index],
        );
      },
    );
  }
}
