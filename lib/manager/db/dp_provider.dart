
import 'package:fun_reader/manager/db/db_manager.dart';
import 'package:sqflite/sqflite.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 14:02
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

abstract class DBProvider{

  bool isTableExit = false;

  tableName();

  tableSql();
  
  Future<Database> getDB() async{
    return await _open();
  }


  _open() async{
    if(!isTableExit){
      await createTable(tableName(),tableSql());
    }
    return await DBManager.getDatabase();
  }

  ///建表
  createTable(String tableName,String tableSql) async{
    isTableExit = await DBManager.isTableExits(tableName);
    if(!isTableExit){
      Database db = await DBManager.getDatabase();
      return db.execute(tableSql);
    }
  }
}

