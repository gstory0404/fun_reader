import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_novel/pages/welcome/welcome_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/7 15:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class WelcomePage extends GetWidget<WelComeCtr>{

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => Text("启动页${controller.countdown.value}")),
      ),
    );
  }

}

