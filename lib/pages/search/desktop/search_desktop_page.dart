import 'package:flutter/material.dart';
import 'package:fun_reader/entity/search_bean.dart';
import 'package:fun_reader/pages/search/desktop/search_desktop_appbar.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:fun_reader/widgets/book_item.dart';
import 'package:fun_reader/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 11:38
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchDesktopPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchDesktopAppbar(),
      body: GetBuilder<SearchCtr>(
        builder: (controller) {
          return StatusWidget(loadType: controller.loadStatus, body: ListView.builder(
            itemCount: controller.searchBooks.length,
            itemBuilder: (BuildContext context, int index) {
              return _books(controller.searchBooks[index]);
            },
          ));
        },
      )
    );
  }

  _books(SearchBean searchBean) {
    return ListView.builder(
      itemCount: searchBean.books?.length,
      itemBuilder: (BuildContext context, int index) {
        return BookItem(
          sourceUrl: searchBean.rule?.sourceUrl ?? "",
          bookBean: searchBean.books![index],
        );
      },
    );
  }
}
