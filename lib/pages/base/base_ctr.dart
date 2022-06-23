import 'package:fun_reader/pages/widgets/status_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/23 10:07
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述


abstract class BaseCtr extends GetxController{
  var loadStatus = LoadType.main.obs;

  void showLoading(){
    loadStatus.value = LoadType.loading;
  }

  void showEmpty(){
    loadStatus.value = LoadType.empty;
  }

  void showError(){
    loadStatus.value = LoadType.error;
  }

  void showMain(){
    loadStatus.value = LoadType.main;
  }
}
