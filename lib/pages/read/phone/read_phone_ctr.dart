import 'package:flutter/material.dart';
import 'package:fun_reader/manager/sp_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 17:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadPhoneCtr extends GetxController{
  //字体大小
  var fontSize = 0.obs;
  //文本左右间隔
  var widthMargin = 0.0.obs;
  //行间距
  var lineHeight = 1.0.obs;
  //字体
  var fontFamily = "".obs;
  //背景颜色
  Rx<Color> bgColor = Rx<Color>(Color(0xfffcf6ef));
  //字体颜色
  Rx<Color> fontColor = Rx<Color>(Color(0xff5E432E));

  var fontSizeList = [10,12,14,16,18,20];
  var widthMarginList = [10.0,12.0,14.0,16.0,18.0,20.0];
  var lineHeightList = [1.1,1.2,1.3,1.4,1.5,1.6];
  var fontFamilyList = ["1","2"];
  var bgColorList = [Color(0xfffcf6ef),Color(0xffF3F3F3),Color(0xff333333),Color(0xffd3e4d3),Color(0xffe8cdcd)];
  var fontColorList = [Color(0xff5E432E),Color(0xff3E3D3B),Color(0xffF4F4F4),Color(0xff22482C),Color(0xff403333)];

  SPManager sp = SPManager();

  @override
  void onInit() {
    super.onInit();
    initSetting();
  }

  //初始化
  void initSetting(){
    //字体大小
    int fontSizeIndex =  sp.get<int>("fontSize", 0);
    fontSize.value = fontSizeList[fontSizeIndex];
    //文本左右间隔
    int widthMarginIndex =  sp.get<int>("fontSize", 0);
    widthMargin.value = widthMarginList[widthMarginIndex];
    //行间距
    int lineHeightIndex = sp.get<int>("lineHeight", 0);
    lineHeight.value = lineHeightList[lineHeightIndex];
    //字体
    int fontFamilyIndex =  sp.get<int>("fontFamily", 0);
    fontFamily.value = fontFamilyList[fontFamilyIndex];
    //背景颜色
    int bgColorIndex = sp.get<int>("bgColor", 0);
    bgColor.value = bgColorList[bgColorIndex];
    //字体颜色
    int fontColorIndex = sp.get<int>("fontColor", 0);
    fontColor.value = bgColorList[fontColorIndex];
  }

  //设置字体大小
  void setFontSize(int index){
    sp.save("fontSize", index);
    fontSize.value = fontSizeList[index];
  }

  //设置文本左右间隔
  void setWidthMargin(int index){
    sp.save("widthMargin", index);
    widthMargin.value = widthMarginList[index];
  }

  //设置行间距
  void setLineHeight(int index){
    sp.save("lineHeight", index);
    lineHeight.value = lineHeightList[index];
  }

  //设置字体
  void setFontFamily(int index){
    sp.save("fontFamily", index);
    fontFamily.value = fontFamilyList[index];
  }

  //设置背景颜色
  void setBgColor(int index){
    sp.save("bgColor", index);
    bgColor.value = bgColorList[index];
  }

  //设置背景颜色
  void setFontColor(int index){
    sp.save("bgColor", index);
    fontColor.value = fontColorList[index];
  }
}


