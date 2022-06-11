import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fun_novel/pages/read/read_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:49
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadPhonePage extends GetView<ReadCtr>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("阅读页"),
      ),
    );
  }

}

