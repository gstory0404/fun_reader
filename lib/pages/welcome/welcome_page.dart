import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/welcome/welcome_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/7 15:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class WelcomePage extends GetWidget<WelComeCtr> {
  const WelcomePage({Key? key}) : super(key: key);

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
            margin: EdgeInsets.only(top: 100,bottom: 30),
            child: Image.asset(
              "assets/images/logo.png",
              width: 80,
              height: 80,
            ),
          ),
          Text(Keys.appName.tr,style: TextStyle(fontSize: 22,color: Colors.black),),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child: const Text("开源免费阅读"),
            ),
          ),
        ],
      )),
    );
  }
}
