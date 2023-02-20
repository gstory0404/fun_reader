import 'package:fun_reader/manager/sp_manager.dart';
import 'package:fun_reader/pages/base/base_ctr.dart';
import 'package:fun_reader/utils/language_util.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/21 18:01
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class MyCtr extends BaseCtr{

  SPManager spManager = SPManager();

  //当前语言
  var language = "";

  @override
  void onInit() {
    super.onInit();
    language = LanguageUtil.getLanguage();
  }

  //选择语言
  void selectLanguage(String lan){
    LanguageUtil.setLanguage(lan);
    language = lan;
    update();
  }
}

