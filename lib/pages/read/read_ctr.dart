import 'package:flutter/material.dart';
import 'package:fun_novel/entity/book_detail_bean.dart';
import 'package:fun_novel/entity/chapter_bean.dart';
import 'package:fun_novel/entity/chapter_content_bean.dart';
import 'package:fun_novel/entity/rule_bean.dart';
import 'package:fun_novel/manager/my_connect.dart';
import 'package:fun_novel/utils/log_util.dart';
import 'package:fun_novel/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadCtr extends GetxController {
  MyConnect connect = Get.find();

  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0;

  var index = 0;

  //书籍相关参数
  var book = BookDetailBean().obs;

  RuleBean? rule;

  //章节内容列表
  var chapterContentList = <ChapterContentBean>[].obs;

  final ItemScrollController readScrollController = ItemScrollController();
  final ItemPositionsListener readPositionsListener =
      ItemPositionsListener.create();

  @override
  void onInit() {
    super.onInit();
    //监听垂直观看是滚动
    readPositionsListener.itemPositions.addListener(() => _checkChapter(
        readPositionsListener.itemPositions.value.toList()[0].index,
        readPositionsListener.itemPositions.value.toList()[0].itemLeadingEdge));
  }

  bool isLoad = false;

  //竖直阅读的时候监听滚动
  void _checkChapter(int index, double up) async {
    if(!isLoad){
      chapterIndex = getChapterPostion(chapterContentList[index].chapterUrl);
      //如果存在上一章 接预加载
      if(index == 0 && up == 0 && chapterIndex > 0){
        isLoad = true;
        chapterContentList.insert(
            0,
            await getChapterContent(
                book.value.chapterList[chapterIndex - 1].chapterName!,
                book.value.chapterList[chapterIndex - 1].chapterUrl!));
        isLoad = false;
        //延时跳转
        Future.delayed(const Duration(milliseconds: 100), () {
          readScrollController.jumpTo(index: index + 1, alignment: up);
        });
      }
      //如果存在下一章 则预加载
      if (index == chapterContentList.length - 1 && chapterIndex < book.value.chapterList.length - 1) {
        isLoad = true;
        print(book.value.chapterList[chapterIndex +1].chapterUrl);
        chapterContentList.add(await getChapterContent(
            book.value.chapterList[chapterIndex +1].chapterName!,
            book.value.chapterList[chapterIndex +1].chapterUrl!));
        isLoad = false;
      }
    }
  }

  int getChapterPostion(String chapterUrl) {
    for (int i = 0; i < book.value.chapterList.length; i++) {
      if (book.value.chapterList[i].chapterUrl == chapterUrl) {
        return i;
      }
    }
    return 0;
  }

  @override
  void onReady() {
    super.onReady();
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    chapterIndex = Get.arguments["chapterIndex"];
    //解析规则
    rule = connect.spiderManager.getRule(sourceUrl);
    if (rule == null) {
      ToastUtil.showToast("$sourceUrl解析规则获取失败");
      Get.back();
    } else {
      getBookDetail();
    }
  }

  //获取书籍详情
  Future<void> getBookDetail() async {
    book.value = await connect.getBookDetail(rule!, bookUrl);
    reloadChapter();
  }

  //重新加载章节内容
  Future<void> reloadChapter() async {
    if (book.value.chapterList.isEmpty) {
      ToastUtil.showToast("暂未获取到章节列表");
      return;
    }
    //加载上一章
    List<ChapterContentBean> lists = [];
    if (chapterIndex > 0) {
      lists.add(await getChapterContent(
          book.value.chapterList[chapterIndex - 1].chapterName!,
          book.value.chapterList[chapterIndex - 1].chapterUrl!));
    }
    lists.add(await getChapterContent(
        book.value.chapterList[chapterIndex].chapterName!,
        book.value.chapterList[chapterIndex].chapterUrl!));
    //加载下一章
    if (chapterIndex < book.value.chapterList.length) {
      lists.add(await getChapterContent(
          book.value.chapterList[chapterIndex + 1].chapterName!,
          book.value.chapterList[chapterIndex + 1].chapterUrl!));
    }
    chapterContentList.clear();
    chapterContentList.addAll(lists);
    //延时跳转
    Future.delayed(const Duration(milliseconds: 100), () {
      if (chapterIndex == 0) {
        readScrollController.jumpTo(index: 0, alignment: 0);
      } else if (chapterIndex > 0 && chapterContentList.length > 1) {
        readScrollController.jumpTo(index: 1, alignment: 0);
      }
    });
  }

  //获取章节内容
  Future<ChapterContentBean> getChapterContent(
      String chapterName, String chapterUrl) async {
    var content = await connect.getChapterContent(rule!, chapterUrl);
    return ChapterContentBean(
        chapterName: chapterName,
        chapterUrl: chapterUrl,
        chapterContent: content);
  }
}
