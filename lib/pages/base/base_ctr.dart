import 'package:fun_reader/widgets/status_widget.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/23 10:07
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述


abstract class BaseCtr extends GetxController{
  var loadStatus = LoadType.main;

  void showLoading(){
    loadStatus = LoadType.loading;
  }

  void showEmpty(){
    loadStatus = LoadType.empty;
  }

  void showError(){
    loadStatus = LoadType.error;
  }

  void showMain(){
    loadStatus = LoadType.main;
  }
}
