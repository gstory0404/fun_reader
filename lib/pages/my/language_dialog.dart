import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/my/my_ctr.dart';
import 'package:fun_reader/pages/my/my_page.dart';
import 'package:fun_reader/utils/language_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 09:42
/// @Email gstory0404@gmail.com
/// @Description: 选择语言

class LanguageDialog {
  static void showLanguageDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(Keys.selectLanguage.tr),
            actions: <Widget>[
              _languageItem(LanguageUtil.auto, Keys.auto.tr),
              _languageItem(LanguageUtil.zh, Keys.simplifiedChinese.tr),
              _languageItem(LanguageUtil.en, Keys.english.tr),
            ],
          );
        });
  }

  static _languageItem(String language, String languageStr) {
    MyCtr ctr = Get.find();
    return Obx(
      () => ListTile(
        title: Text(
          languageStr,
          style: TextStyle(
            color: ctr.language.value == language ? Colors.red : Colors.black,
          ),
        ),
        selected: ctr.language.value == language,
        onTap: () {
          ctr.selectLanguage(language);
        },
      ),
    );
  }
}
