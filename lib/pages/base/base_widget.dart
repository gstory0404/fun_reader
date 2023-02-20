import 'dart:io';

import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/9 15:58
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

abstract class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key}) : super(key: key);

  ///手机页面
  Widget phonePage(BuildContext context);

  ///桌面页面
  Widget desktopPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid || Platform.isIOS
        ? phonePage(context)
        : desktopPage(context);
  }
}
