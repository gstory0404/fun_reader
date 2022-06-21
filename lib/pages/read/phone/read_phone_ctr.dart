import 'package:flutter/material.dart';
import 'package:fun_reader/manager/sp_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 17:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ReadPhoneCtr extends GetxController {
  //字体大小
  var fontSize = 0.obs;

  //文本左右间隔
  var widthMargin = 0.obs;

  //行间距
  var fontHeight = 0.obs;

  //字体
  var fontFamily = 0.obs;

  //背景颜色
  var bgColor = 0.obs;

  //字体颜色
  var fontColor = 0.obs;

  var fontSizeList = [10.0, 12.0, 14.0, 16.0, 18.0, 20.0, 22.0,24.0];
  var widthMarginList = [10.0, 12.0, 14.0, 16.0, 18.0, 20.0,22.0,24.0,26.0];
  var fontHeightList = [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0];
  var fontFamilyList = ["", "shufajiaxingkai", "huawenxingkai"];
  var fontFamilyStrList = ["默认", "书法家行楷体", "华文行楷体"];
  var bgColorList = [
    const Color(0xfffcf6ef),
    const Color(0xffF3F3F3),
    const Color(0xff333333),
    const Color(0xffd3e4d3),
    const Color(0xffe8cdcd)
  ];
  var fontColorList = [
    const Color(0xff5E432E),
    const Color(0xff3E3D3B),
    const Color(0xffF4F4F4),
    const Color(0xff22482C),
    const Color(0xff403333)
  ];

  SPManager sp = SPManager();

  @override
  void onInit() {
    super.onInit();
    initSetting();
  }

  //初始化
  void initSetting() {
    //字体大小
    fontSize.value = sp.get<int>("fontSize", 4);
    //文本左右间隔
    widthMargin.value = sp.get<int>("widthMargin", 3);
    //行间距
    fontHeight.value = sp.get<int>("fontHeight", 5);
    //字体
    // fontFamily.value = sp.get<int>("fontFamily", 0);
    fontFamily.value = 0;
    //背景颜色
    bgColor.value = sp.get<int>("bgColor", 3);
    //字体颜色
    fontColor.value = sp.get<int>("fontColor", 1);
  }

  //设置字体大小
  void setFontSize(int index) {
    sp.save("fontSize", index);
    fontSize.value = index;
  }

  //设置文本左右间隔
  void setWidthMargin(int index) {
    sp.save("widthMargin", index);
    widthMargin.value = index;
  }

  //设置行间距
  void setFontHeight(int index) {
    sp.save("fontHeight", index);
    fontHeight.value = index;
  }

  //设置字体
  void setFontFamily(int index) {
    sp.save("fontFamily", index);
    fontFamily.value = index;
  }

  //设置背景颜色
  void setBgColor(int index) {
    sp.save("bgColor", index);
    bgColor.value = index;
  }

  //设置背景颜色
  void setFontColor(int index) {
    sp.save("bgColor", index);
    fontColor.value = index;
  }
}
