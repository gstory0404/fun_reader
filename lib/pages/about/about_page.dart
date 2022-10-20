import 'package:flutter/material.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/22 17:38
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AboutPage extends StatefulWidget {
  static void go() {
    Get.toNamed(Routes.ABOUT);
  }

  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  var version = "";

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = "v${packageInfo.version}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 100),
            child: Image.asset(
              "assets/images/logo.png",
              width: 80,
              height: 80,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              Keys.appName.tr,
              style: const TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 50),
            child: Text(
              version,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                //项目地址
                InkWell(
                  onTap: () async {
                    await launchUrl(
                        Uri.parse("https://github.com/gstory0404/fun_reader"));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "项目地址",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                //书源规则
                InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "https://github.com/gstory0404/fun_reader/blob/master/rule.md"));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "书源规则",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
                //开源协议
                InkWell(
                  onTap: () async {
                    await launchUrl(Uri.parse(
                        "https://github.com/gstory0404/fun_reader/blob/master/LICENSE"));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFEEEEEE), width: 1)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "开源协议",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            child: const Text("开源免费阅读"),
          )
        ],
      )),
    );
  }
}
