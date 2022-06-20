import 'dart:async';

import 'package:flutter/material.dart';
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
              isShowProgress.value = true;
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
                ToastUtil.showToast("已经是第一章了");
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
                ToastUtil.showToast("已经是最后一章了");
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
    print("xianshi l");
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white24))),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        children: [
          // Container(
          //   child: Obx(
          //     () => ProgressWidget(
          //       defaultValue: 0.5,
          //       maxValue: 1,
          //       onChange: (value) {},
          //       onFinish: (value) {},
          //     ),
          //   ),
          // ),
          Row(
            children: [
              Text(
                "背景",
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
          )
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
