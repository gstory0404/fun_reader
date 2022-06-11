import 'package:flutter/material.dart';
import 'package:fun_novel/entity/chapter_bean.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 14:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ChapterPage extends StatefulWidget {
  List<ChapterBean> chapterList;
  String? chapterId;
  String bookId;

  ChapterPage({Key? key,required this.bookId, required this.chapterList, this.chapterId = ""})
      : super(key: key);

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    for (int i = 0; i < widget.chapterList.length; i++) {
      if (widget.chapterList[i].id == widget.chapterId) {
        _scrollController.animateTo(i * 30,
            duration: const Duration(milliseconds: 100), curve: Curves.ease);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: context.width,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 50, bottom: 20),
              color: Colors.black12,
              child: Text(
                "章节列表",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: VsScrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                showTrackOnHover: true,
                style: const VsScrollbarStyle(
                  hoverThickness: 20.0, // default 12.0
                  radius: Radius.circular(10), // default Radius.circular(8.0)
                  thickness: 16.0, // [ default 8.0 ]
                  color: Colors.red, // default ColorScheme Theme
                ),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.chapterList.length,
                  itemExtent: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Get.toNamed(Routes.READ, arguments: {"bookId": widget.bookId,"chapterId":widget.chapterList[index].id});
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          widget.chapterList[index].name!,
                          style: TextStyle(
                              fontSize: 15,
                              color: widget.chapterId!.isNotEmpty
                                  ? (widget.chapterId ==
                                          widget.chapterList[index].id
                                      ? Colors.red
                                      : Colors.black)
                                  : Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
