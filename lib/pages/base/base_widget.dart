import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 15:58
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

abstract class BaseWidget<S extends GetLifeCycleBase> extends GetWidget<S>{

  const BaseWidget({Key? key}) : super(key: key);

  Widget phonePage();

  Widget desktopPage();

  @override
  Widget build(BuildContext context) {
    return context.isPhone ? phonePage() : desktopPage();
  }
}

