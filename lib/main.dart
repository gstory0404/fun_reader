import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isFuchsia || Platform.isLinux || Platform.isMacOS || Platform.isWindows){
    initWindow();
  }
  runApp(const MyApp());
}

void initWindow() async {
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async{
    // 隐藏窗口标题栏
    await windowManager.setTitleBarStyle('hidden');
    await windowManager.setSize(const Size(540, 880));
    // await windowManager.setMaximumSize(const Size(1000, 1000));
    await windowManager.setMinimumSize(const Size(540, 880));
    await windowManager.center();
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}