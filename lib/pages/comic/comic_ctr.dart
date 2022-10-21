import 'package:fun_reader/entity/book_detail_bean.dart';
import 'package:fun_reader/entity/chapter_bean.dart';
import 'package:fun_reader/entity/comic_chapter_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/entity/rule_bean.dart';
import 'package:fun_reader/manager/db/book_dao.dart';
import 'package:fun_reader/manager/db/rule_dao.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/utils/date_util.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

/// @Author: gstory
/// @CreateDate: 2022/10/21 12:09
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ComicCtr extends BaseCtr {
  MyConnect connect = Get.find();
  var sourceUrl = "";
  var bookUrl = "";
  var chapterIndex = 0.obs;
  DBRuleBean? rule;

  //章节内容列表
  var chapterContentList = <ComicChapterContent>[].obs;

  //书籍相关参数
  var book = BookDetailBean().obs;

  //是否显示菜单页面
  var isShowMenu = false.obs;

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
                book.value.chapterList[chapterIndex.value - 1]));
        //延时跳转
        Future.delayed(const Duration(milliseconds: 10), () {
          readScrollController.jumpTo(index: index + 1, alignment: 0);
        });
      }
      //如果存在下一章 则预加载
      if (index == chapterContentList.length - 1 &&
          chapterIndex < book.value.chapterList.length - 1) {
        chapterContentList.add(await getChapterContent(
            book.value.chapterList[chapterIndex.value + 1]));
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

  ///重置列表
  void reloadChapter() {
    isLoad = true;
    getChapterContent(book.value.chapterList[chapterIndex.value])
        .then((value) => {
              chapterContentList.clear(),
              chapterContentList.add(value),
              isLoad = false,
            });
  }

  //获取章节内容
  Future<ComicChapterContent> getChapterContent(ChapterBean chapterBean) async {
    var contents = await connect.getComicChapterContent(
        rule!.ruleBean!, chapterBean.chapterUrl ?? "");
    return ComicChapterContent(
      chapterName: chapterBean.chapterName ?? "",
      chapterUrl: chapterBean.chapterUrl ?? "",
      contents: contents,
    );
  }
}
