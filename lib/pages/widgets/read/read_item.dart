import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_reader/entity/chapter_content_bean.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/15 15:59
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadItem extends GetView<ReadCtr> {

  ChapterContentBean chapter;

  ReadItem({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.isShowMenu.value = true;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        // color: backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                chapter.chapterName,
                style: TextStyle(
                    fontSize: 20
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: context.height * 0.8),
              child: Text(
                chapter.chapterContent,
                style: TextStyle(
                  // color: textColor,
                  // fontSize: ScreenUtil().setSp(fontSize),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


