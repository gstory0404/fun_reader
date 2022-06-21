import 'dart:ui';

import 'package:get/get.dart';
import 'package:fun_reader/lang/keys.dart';

import 'en_US.dart';
import 'zh_CN.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/21 17:10
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class TranslationService extends Translations {

  static Locale? get locale => Get.deviceLocale;

  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'zh_CN': zh_CN,
  };
}

