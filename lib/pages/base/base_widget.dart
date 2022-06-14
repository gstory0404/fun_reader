import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 15:58
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

abstract class BaseWidget<S extends GetLifeCycleBase> extends GetView<S>{

  const BaseWidget({Key? key}) : super(key: key);

  Widget phonePage(BuildContext context);

  Widget desktopPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return context.isPhone ? phonePage(context) : desktopPage(context);
  }
}

