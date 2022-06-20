import 'package:shared_preferences/shared_preferences.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 16:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class SPManager{

  static SPManager? _instance;
  factory SPManager() => _instance ??= SPManager._initial();
  SharedPreferences? _preferences;
  SPManager._initial() {
    // init();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }


  ///保存数据
  SPManager save(String key, dynamic value) {
    switch(value.runtimeType){
      case int:
        _preferences?.setInt(key, value);
        break;
      case bool:
        _preferences?.setBool(key, value);
        break;
      case double:
        _preferences?.setDouble(key, value);
        break;
      case String:
        _preferences?.setString(key, value);
        break;
      case List<String>:
        _preferences?.setStringList(key, value);
        break;
      default:
        _preferences?.setString(key, value.toString());
        break;
    }
    return this;
  }

  ///获取数据
  T get<T>(String key,dynamic defaultValue){
    switch (T) {
      case int:
        return _preferences?.getInt(key) ?? defaultValue;
      case bool:
        return _preferences?.getBool(key) ?? defaultValue;
      case double:
        return _preferences?.getDouble(key) ?? defaultValue;
      case String:
        return _preferences?.getString(key) ?? defaultValue;
      case List<String>:
        return _preferences?.getStringList(key) ?? defaultValue;
    }
    return _preferences?.get(key) ?? defaultValue;
  }

  ///删除key
  Future<bool> remove(String key) async{
   return await _preferences?.remove(key) ?? false;
  }

  ///清空
  Future<bool> clear() async{
    return await _preferences?.clear() ?? false;
  }
}

