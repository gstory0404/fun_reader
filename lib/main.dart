import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fun_reader/lang/translation_service.dart';
import 'package:fun_reader/manager/my_connect.dart';
import 'package:fun_reader/routes/app_pages.dart';
import 'package:fun_reader/utils/log_util.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initWindow();
  initServer();
  runApp(const MyApp());
}

void initServer() async {
  Get.put(MyConnect(), permanent: true);
  LogUtil.init(isDebug: true);
}

void initWindow() async {
  if (Platform.isFuchsia ||
      Platform.isLinux ||
      Platform.isMacOS ||
      Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      // 隐藏窗口标题栏
      await windowManager.setTitleBarStyle(TitleBarStyle.normal);
      await windowManager.setSize(const Size(800, 880));
      // await windowManager.setMaximumSize(const Size(1000, 1000));
      await windowManager.setMinimumSize(const Size(540, 880));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setSkipTaskbar(false);
    });
  } else if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}
