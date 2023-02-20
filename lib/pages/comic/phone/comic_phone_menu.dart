import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fun_reader/pages/comic/comic_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/10/21 16:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ComicPhoneMenu extends StatefulWidget {
  Function()? openDraw;

  ComicPhoneMenu({Key? key, this.openDraw}) : super(key: key);

  @override
  State<ComicPhoneMenu> createState() => _ComicPhoneMenuState();
}

class _ComicPhoneMenuState extends State<ComicPhoneMenu>
    with SingleTickerProviderStateMixin {
  ComicCtr comicCtr = Get.find();
  late AnimationController animationController;
  late Animation<double> animation;

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
      comicCtr.isShowMenu.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
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
        decoration: const BoxDecoration(
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
              icon: const Icon(
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
                    comicCtr.book.bookName ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )),
            IconButton(
              icon: const Icon(
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
      bottom: 60,
      right: 30,
      child: InkWell(
        onTap: () {
          if (widget.openDraw != null) {
            widget.openDraw!();
          }
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
