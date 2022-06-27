import 'package:flutter/material.dart';
import 'package:fun_reader/entity/chapter_content_bean.dart';
import 'package:fun_reader/pages/read/read_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/15 15:59
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadPhoneItem extends StatelessWidget {
  ChapterContentBean chapter;

  ReadPhoneItem({required this.chapter});

  @override
  Widget build(BuildContext context) {
    return GetX<ReadCtr>(
      builder: (controller) {
        return GestureDetector(
            onTap: () {
              controller.isShowMenu.value = true;
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: controller.readPhoneCtr.widthMarginList[controller.readPhoneCtr.widthMargin.value]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      chapter.chapterName,
                      style: TextStyle(
                          fontSize: controller.readPhoneCtr.fontSizeList[controller.readPhoneCtr.fontSize.value] + 3,
                          fontFamily: controller.readPhoneCtr.fontFamilyList[controller.readPhoneCtr.fontFamily.value],
                          color: controller.readPhoneCtr.fontColorList[controller.readPhoneCtr.fontColor.value],
                          height: controller.readPhoneCtr.fontHeightList[controller.readPhoneCtr.fontHeight.value]),
                    ),
                  ),
                  Container(
                    constraints:
                        BoxConstraints(minHeight: context.height * 0.8),
                    child: Text(
                      chapter.chapterContent,
                      style: TextStyle(
                          fontSize: controller.readPhoneCtr.fontSizeList[controller.readPhoneCtr.fontSize.value],
                          fontFamily: controller.readPhoneCtr.fontFamilyList[controller.readPhoneCtr.fontFamily.value],
                          color: controller.readPhoneCtr.fontColorList[controller.readPhoneCtr.fontColor.value],
                          height: controller.readPhoneCtr.fontHeightList[controller.readPhoneCtr.fontHeight.value]),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
