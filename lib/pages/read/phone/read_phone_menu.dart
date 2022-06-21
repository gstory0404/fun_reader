import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:fun_reader/pages/widgets/read/progress_widget.dart';
import 'package:fun_reader/utils/toast_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/16 10:07
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadPhoneMenu extends StatefulWidget {
  Function()? openDraw;

  ReadPhoneMenu({Key? key, this.openDraw}) : super(key: key);

  @override
  State<ReadPhoneMenu> createState() => _ReadPhoneMenuState();
}

class _ReadPhoneMenuState extends State<ReadPhoneMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final ReadCtr readCtr = Get.find();

  //进度
  var isShowProgress = false.obs;

  //背景
  var isShowBg = false.obs;

  //字体
  var isShowFont = false.obs;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  //影藏
  hide() {
    animationController.reverse();
    Timer(const Duration(milliseconds: 200), () {
      readCtr.isShowMenu.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (isShowProgress.value) {
                isShowProgress.value = false;
                return;
              }
              if (isShowBg.value) {
                isShowBg.value = false;
                return;
              }
              if (isShowFont.value) {
                isShowFont.value = false;
                return;
              }
              hide();
            },
            child: Container(color: Colors.transparent),
          ),
          _buildTopView(context),
          _buildBottomView(),
        ],
      ),
    );
  }

  //头部
  _buildTopView(BuildContext context) {
    return Positioned(
      top: -context.mediaQueryPadding.top * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        height: context.mediaQueryPadding.top + 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    readCtr.book.value.bookName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  //底部设置栏
  _buildBottomView() {
    return Positioned(
      bottom: -(context.mediaQueryPadding.bottom + 100) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Container(
            // 上边框
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                top: BorderSide(width: 1, color: Colors.white),
              ),
            ),
            padding: EdgeInsets.only(bottom: context.mediaQueryPadding.bottom),
            child: Column(
              children: <Widget>[
                Obx(() =>
                    isShowProgress.value ? _buildProgressView() : Container()),
                Obx(() => isShowBg.value ? _buildBgSettingView() : Container()),
                Obx(() =>
                    isShowFont.value ? _buildFontSettingView() : Container()),
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //底部菜单栏
  buildBottomMenus() {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //目录
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              isShowProgress.value = false;
              isShowBg.value = false;
              isShowFont.value = false;
              if (widget.openDraw != null) {
                widget.openDraw!();
              }
            },
          ),
          //进度
          IconButton(
            icon: Icon(
              Icons.commit,
              color: Colors.white,
            ),
            onPressed: () {
              isShowBg.value = false;
              isShowFont.value = false;
              isShowProgress.value = !isShowProgress.value;
            },
          ),
          //背景
          IconButton(
            icon: Icon(
              Icons.sunny,
              color: Colors.white,
            ),
            onPressed: () {
              isShowProgress.value = false;
              isShowFont.value = false;
              isShowBg.value = !isShowBg.value;
            },
          ),
          //字体
          IconButton(
            icon: Icon(
              Icons.text_format,
              color: Colors.white,
            ),
            onPressed: () {
              isShowProgress.value = false;
              isShowBg.value = false;
              isShowFont.value = !isShowFont.value;
            },
          ),
        ],
      ),
    );
  }

  //进度设置栏
  _buildProgressView() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white24))),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (readCtr.chapterIndex.value == 0) {
                ToastUtil.showToast(Keys.firstChapterTips.tr);
                return;
              }
              readCtr.chapterIndex.value = readCtr.chapterIndex.value - 1;
              readCtr.reloadChapter();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: const Icon(
                Icons.first_page,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Obx(
                () => ProgressWidget(
                  defaultValue: readCtr.chapterIndex.value.toDouble(),
                  maxValue:
                      readCtr.book.value.chapterList.length.toDouble() - 1,
                  onChange: (value) {
                    ToastUtil.showToast(readCtr.book.value
                            .chapterList[value.toInt()].chapterName ??
                        "");
                  },
                  onFinish: (value) {
                    readCtr.chapterIndex.value = value.toInt();
                    readCtr.reloadChapter();
                  },
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (readCtr.chapterIndex.value >=
                  readCtr.book.value.chapterList.length - 1) {
                ToastUtil.showToast(Keys.lastChapterTips.tr);
                return;
              }
              readCtr.chapterIndex.value = readCtr.chapterIndex.value + 1;
              readCtr.reloadChapter();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.last_page,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  //背景设置
  _buildBgSettingView() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white24))),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Row(
        children: [
          Text(
            Keys.background.tr,
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: Container(
              height: 40,
              child: ListView.builder(
                  itemCount: readCtr.readPhoneCtr.bgColorList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        readCtr.readPhoneCtr.setBgColor(index);
                      },
                      child: Container(
                          width: 40,
                          height: 40,
                          margin: const EdgeInsets.only(left: 14),
                          decoration: BoxDecoration(
                            color: readCtr.readPhoneCtr.bgColorList[index],
                            borderRadius: BorderRadius.circular(20),
                          )),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  //字体设置
  _buildFontSettingView() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white24))),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Keys.fontSize.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.fontSize.value > 0) {
                              readCtr.readPhoneCtr.setFontSize(
                                  readCtr.readPhoneCtr.fontSize.value - 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Obx(() => Text(
                              "${readCtr.readPhoneCtr.fontSizeList[readCtr.readPhoneCtr.fontSize.value]}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            )),
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.fontSize.value <
                                readCtr.readPhoneCtr.fontSizeList.length - 1) {
                              readCtr.readPhoneCtr.setFontSize(
                                  readCtr.readPhoneCtr.fontSize.value + 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Keys.lineSpacing.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.fontHeight.value > 0) {
                              readCtr.readPhoneCtr.setFontHeight(
                                  readCtr.readPhoneCtr.fontHeight.value - 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Obx(() => Text(
                              "${readCtr.readPhoneCtr.fontHeightList[readCtr.readPhoneCtr.fontHeight.value]}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            )),
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.fontHeight.value <
                                readCtr.readPhoneCtr.fontHeightList.length -
                                    1) {
                              readCtr.readPhoneCtr.setFontHeight(
                                  readCtr.readPhoneCtr.fontHeight.value + 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text(
                  Keys.horizontalSpacing.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.widthMargin.value > 0) {
                              readCtr.readPhoneCtr.setWidthMargin(
                                  readCtr.readPhoneCtr.widthMargin.value - 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        Obx(() => Text(
                              "${readCtr.readPhoneCtr.widthMarginList[readCtr.readPhoneCtr.widthMargin.value]}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            )),
                        IconButton(
                          onPressed: () {
                            if (readCtr.readPhoneCtr.widthMargin.value <
                                readCtr.readPhoneCtr.widthMarginList.length -
                                    1) {
                              readCtr.readPhoneCtr.setWidthMargin(
                                  readCtr.readPhoneCtr.widthMargin.value + 1);
                            }
                          },
                          icon: const Icon(
                            Icons.text_increase,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Keys.font.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: readCtr.readPhoneCtr.fontFamilyList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              readCtr.readPhoneCtr.setFontFamily(index);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 14),
                              margin: const EdgeInsets.only(left: 14),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white, width: 0.5), // border
                                borderRadius: BorderRadius.circular((8)), // 圆角
                              ),
                              child: Text(
                                readCtr.readPhoneCtr.fontFamilyStrList[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white30))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Keys.fontColor.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    child: ListView.builder(
                        itemCount: readCtr.readPhoneCtr.fontColorList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              readCtr.readPhoneCtr.setFontColor(index);
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                margin: const EdgeInsets.only(left: 14),
                                decoration: BoxDecoration(
                                  color:
                                      readCtr.readPhoneCtr.fontColorList[index],
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
