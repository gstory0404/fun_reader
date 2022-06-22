import 'dart:ui';

import 'package:fun_reader/manager/sp_manager.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 09:54
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class LanguageUtil{

  static const languageKey = "language";

  static const auto = "auto";
  static const en = "en";
  static const zh = "zh";

  //获取当前语言
  static String getLanguage(){
    var language = SPManager().get(languageKey, auto);
    return language;
  }

  //设置语言
  static void setLanguage(String lan){
    SPManager().save(languageKey, lan);
    var locale = getLanguageLocale(lan);
    Get.updateLocale(locale);
  }

  //获取Locale
  static Locale getLanguageLocale(String lan){
    switch(lan){
      case en:
        return const Locale('en', 'US');
      case zh:
        return const Locale('zh', 'CN');
    }
    return Get.deviceLocale ?? const Locale('zh', 'CN');
  }
}


