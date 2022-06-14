import 'package:flutter/material.dart';
import 'package:fun_novel/pages/base/base_widget.dart';
import 'package:fun_novel/pages/read/read_connect.dart';
import 'package:fun_novel/pages/read/read_phone_page.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadPage extends BaseWidget<ReadConnect>{

  @override
  Widget desktopPage(BuildContext context) {
    return Container();
  }

  @override
  Widget phonePage(BuildContext context) {
    return ReadPhonePage();
  }
}

