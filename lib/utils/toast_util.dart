import 'package:flutter_easyloading/flutter_easyloading.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/15 12:09
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ToastUtil {
  //显示toast
  static void showToast(String msg) {
    EasyLoading.showToast(msg);
  }

  static void showLoading(String msg) async {
    await EasyLoading.show(
      status: msg,
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: true,
    );
  }

  static void dismiss() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }
}
