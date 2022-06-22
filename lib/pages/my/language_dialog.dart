import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/my/my_ctr.dart';
import 'package:fun_reader/pages/my/my_page.dart';
import 'package:fun_reader/utils/language_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 09:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LanguageDialog extends GetView<MyCtr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: ListView(
        children: [
          _languageItem(LanguageUtil.auto, Keys.auto.tr),
          _languageItem(LanguageUtil.zh, Keys.simplifiedChinese.tr),
          _languageItem(LanguageUtil.en, Keys.english.tr),
        ],
      ),
    );
  }

  _languageItem(String language, String languageStr) {
    return Obx(
      () => ListTile(
        title: Text(
          languageStr,
          style: TextStyle(
            color: controller.language.value == language
                ? Colors.red
                : Colors.black,
          ),
        ),
        selected: controller.language.value == language,
        onTap: () {
          controller.selectLanguage(language);
        },
      ),
    );
  }
}
