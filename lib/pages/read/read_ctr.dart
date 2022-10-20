import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/chapter_content_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/pages/read/phone/read_phone_ctr.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sqflite/sqflite.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadCtr extends BaseCtr {
  MyConnect connect = Get.find();

  //手机阅读设置
  ReadPhoneCtr readPhoneCtr = Get.put(ReadPhoneCtr());

  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0.obs;

  //书籍相关参数
  var book = BookDetailBean().obs;

  DBRuleBean? rule;

  //章节内容列表
  var chapterContentList = <ChapterContentBean>[].obs;

  final ItemScrollController readScrollController = ItemScrollController();
  final ItemPositionsListener readPositionsListener =
      ItemPositionsListener.create();

  //是否显示菜单页面
  var isShowMenu = false.obs;

  //是否显示设置页面
  var isShowSetting = false.obs;

  @override
  void onInit() {
    super.onInit();
    //监听垂直观看是滚动
    readPositionsListener.itemPositions.addListener(() => _checkChapter(
        readPositionsListener.itemPositions.value.toList()[0].index,
        readPositionsListener.itemPositions.value.toList()[0].itemLeadingEdge));
  }

  bool isLoad = true;

  //竖直阅读的时候监听滚动
  void _checkChapter(int index, double up) async {
    if (!isLoad) {
      isLoad = true;
      chapterIndex.value =
          getChapterPostion(chapterContentList[index].chapterUrl);
      //更新阅读记录
      if (chapterIndex.value != book.value.lastReadIndex) {
        book.value.lastReadIndex = chapterIndex.value;
        book.value.lastReadUrl =
            book.value.chapterList[chapterIndex.value].chapterUrl;
        book.value.lastReadChapter =
            book.value.chapterList[chapterIndex.value].chapterName;
        book.value.lastReadTime = DateUtil.nowTimestamp();
        await BookDao().update(book.value);
      }
      //如果存在上一章 接预加载
      if (index == 0 && up == 0 && chapterIndex > 0) {
        chapterContentList.insert(
            0,
            await getChapterContent(
                book.value.chapterList[chapterIndex.value - 1].chapterName!,
                book.value.chapterList[chapterIndex.value - 1].chapterUrl!));
        //延时跳转
        Future.delayed(const Duration(milliseconds: 10), () {
          readScrollController.jumpTo(index: index + 1, alignment: 0);
        });
      }
      //如果存在下一章 则预加载
      if (index == chapterContentList.length - 1 &&
          chapterIndex < book.value.chapterList.length - 1) {
        chapterContentList.add(await getChapterContent(
            book.value.chapterList[chapterIndex.value + 1].chapterName!,
            book.value.chapterList[chapterIndex.value + 1].chapterUrl!));
      }
      isLoad = false;
    }
  }

  //获取章节下标
  int getChapterPostion(String chapterUrl) {
    for (int i = 0; i < book.value.chapterList.length; i++) {
      if (book.value.chapterList[i].chapterUrl == chapterUrl) {
        return i;
      }
    }
    return 0;
  }

  @override
  void onReady() async {
    super.onReady();
    sourceUrl = Get.arguments['sourceUrl'];
    bookUrl = Get.arguments['bookUrl'];
    chapterIndex.value = Get.arguments["chapterIndex"];
    //解析规则
    rule = await RuleDao().query(sourceUrl);
    if (rule == null) {
      ToastUtil.showToast("$sourceUrl解析规则获取失败");
      Get.back();
    } else {
      getBookDetail();
    }
  }

  //获取书籍详情
  Future<void> getBookDetail() async {
    showLoading();
    connect.getBookDetail(rule!.ruleBean!, bookUrl).then((value) => {
          book.value = value,
          reloadChapter(),
          showMain(),
        });
  }

  //重新加载章节内容
  Future<void> reloadChapter() async {
    isLoad = true;
    if (book.value.chapterList.isEmpty) {
      ToastUtil.showToast("暂未获取到章节列表");
      return;
    }
    //加载上一章
    List<ChapterContentBean> lists = [];
    if (chapterIndex > 0) {
      lists.add(await getChapterContent(
          book.value.chapterList[chapterIndex.value - 1].chapterName!,
          book.value.chapterList[chapterIndex.value - 1].chapterUrl!));
    }
    //加载当前章节
    lists.add(await getChapterContent(
        book.value.chapterList[chapterIndex.value].chapterName!,
        book.value.chapterList[chapterIndex.value].chapterUrl!));
    //加载下一章
    if (chapterIndex < book.value.chapterList.length) {
      lists.add(await getChapterContent(
          book.value.chapterList[chapterIndex.value + 1].chapterName!,
          book.value.chapterList[chapterIndex.value + 1].chapterUrl!));
    }
    chapterContentList.clear();
    chapterContentList.addAll(lists);
    //延时跳转
    Future.delayed(const Duration(milliseconds: 100), () {
      readScrollController.jumpTo(
          index: chapterIndex.value == 0 ? 0 : 1, alignment: 0);
      isLoad = false;
    });
  }

  //获取章节内容
  Future<ChapterContentBean> getChapterContent(
      String chapterName, String chapterUrl) async {
    var content = await connect.getChapterContent(rule!.ruleBean!, chapterUrl);
    return ChapterContentBean(
        chapterName: chapterName,
        chapterUrl: chapterUrl,
        chapterContent: content);
  }
}
