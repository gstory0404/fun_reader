import 'package:fun_novel/pages/read/read_connect.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/11 15:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ReadCtr extends GetxController{
  ReadConnect connect;

  ReadCtr({required this.connect});

  @override
  void onReady() {
    print(Get.arguments);
  }
}


