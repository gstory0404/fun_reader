import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/my/language_dialog.dart';
import 'package:fun_reader/pages/my/my_ctr.dart';
import 'package:fun_reader/pages/source/source_page.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 16:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class MyDesktopPage extends GetView<MyCtr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: context.mediaQueryPadding.top + 100),
            child: Image.asset(
              'assets/images/logo.png',
              width: 60,
              height: 60,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              Keys.appName.tr,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                //书源管理
                InkWell(
                  onTap: (){
                    SourcePage.go();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Keys.bookSourceManage.tr,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                //选择语言
                InkWell(
                  onTap: () async{
                    LanguageDialog.showLanguageDialog(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Keys.languageSettings.tr,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                //关于app
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Keys.about.tr,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


