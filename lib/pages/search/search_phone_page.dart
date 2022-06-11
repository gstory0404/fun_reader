import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_bean.dart';
import 'package:fun_novel/pages/search/search_connect.dart';
import 'package:fun_novel/pages/search/search_ctr.dart';
import 'package:fun_novel/pages/widgets/book_item.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/10 17:37
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

const searchList = ["诛仙", "1", "2", "老鹰"];

class SearchBarDelegate extends SearchDelegate<String> {
  
  SearchCtr searchCtr = Get.put(SearchCtr(connect: Get.put(SearchConnect())));

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        if (query.isEmpty) {
          close(context, "");
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<BookBean>>(
        future: searchCtr.searchBook(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const  Center(
                child: Text("加载数据中..."),
              );
          // 连接到异步任务并开始交互
            case ConnectionState.done:
              if(snapshot.hasError){
                return const Center(
                  child: Text("加载数据失败"),
                );
              }else if(snapshot.hasData){
                var list = snapshot.data!;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return BookItem(bookBean:  list[index],);
                  },
                );
              }
          }
          return Container();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: InkWell(
          onTap: (){
            query = suggestionList[index];
            showResults(context);
          },
          child: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style:
                  const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: const TextStyle(color: Colors.black))
                  ])),
        ),
      ),
    );
  }
}
