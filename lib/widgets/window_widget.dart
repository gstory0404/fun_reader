import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/28 11:46
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class WindowTab {
  String title;
  IconData icon;
  Widget page;

  WindowTab({required this.title, required this.icon, required this.page});
}

class WindowWidget extends StatefulWidget {
  List<WindowTab> tabs;

  WindowWidget({Key? key, required this.tabs}) : super(key: key);

  @override
  State<WindowWidget> createState() => _WindowWidgetState();
}

class _WindowWidgetState extends State<WindowWidget> {
  late PageController pageController;
  var currentPage = 0.obs;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Row(
          children: [
            Container(
              width: 160,
              margin: const EdgeInsets.only(right: 30, top: 40),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      Keys.appName.tr,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ListView.builder(
                          itemCount: widget.tabs.length,
                          itemBuilder: (context, index) {
                            return _tabWidget(index, widget.tabs[index]);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  currentPage.value = index;
                },
                reverse: false,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  return widget.tabs[index].page;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabWidget(int index, WindowTab windowTab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Material(
        child: Obx(
          () => Ink(
            //设置背景
            decoration: BoxDecoration(
              color: currentPage.value == index
                  ? const Color(0xFF12aa9c)
                  : Colors.black12,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            ),
            child: InkResponse(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              highlightColor: const Color(0xFF12aa9c),
              highlightShape: BoxShape.rectangle,
              radius: 1.0,
              splashColor: const Color(0xFF12aa9c),
              containedInkWell: true,
              onTap: () {
                currentPage.value = index;
                pageController.jumpToPage(index);
              },
              child: Container(
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(windowTab.icon,
                        size: 14,
                        color: currentPage.value == index
                            ? Colors.white
                            : Colors.black),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        windowTab.title,
                        style: TextStyle(
                            fontSize: 14,
                            color: currentPage.value == index
                                ? Colors.white
                                : Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
