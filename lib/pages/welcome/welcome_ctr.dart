import 'dart:async';

import 'package:fun_reader/manager/sp_manager.dart';
import 'package:fun_reader/pages/index/index_page.dart';
import 'package:get/get.dart';

class WelcomeCtr extends GetxController {
  Timer? _timer;

  var countdown = 3;

  @override
  Future<void> onInit() async {
    super.onInit();

    await SPManager().init();
    _timer = Timer.periodic(const Duration(seconds: 1),(timer){
      if (countdown > 0) {
        countdown--;
      } else {
        _timer?.cancel();
        _timer = null;
        IndexPage.go();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer = null;
  }
}
