import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/manager/db/dp_provider.dart';
import 'package:fun_reader/utils/log_util.dart';
import 'package:sqflite/sqflite.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/20 15:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class RuleDao extends DBProvider {
  final _tableName = "rules";

  final _tableId = "id";
  final _sourceName = "source_name";
  final _sourceUrl = "source_url";
  final _rule = "rule";
  final _isEffect = "is_effect";

  @override
  tableName() {
    return _tableName;
  }

  @override
  tableSql() {
    return '''
            create table $_tableName (
              $_tableId integer primary key autoincrement,
              $_sourceName TEXT,
              $_sourceUrl TEXT,
              $_rule TEXT,
              $_isEffect INTEGER
              )''';
  }

  ///插入单条规则
  Future<DBRuleBean> insert(DBRuleBean dbRuleBean) async {
    Database db = await getDB();
    dbRuleBean.id = await db.insert(tableName(), dbRuleBean.toJson());
    return dbRuleBean;
  }

  ///查询单条规则
  ///[sourceUrl] 规则 域名
  Future<DBRuleBean?> query(String sourceUrl) async {
    Database db = await getDB();
    final List<Map<String, dynamic>> maps = await db
        .query(_tableName, where: "$_sourceUrl = ?", whereArgs: [sourceUrl]);
    if (maps.isNotEmpty) {
      return DBRuleBean.fromJson(maps[0]);
    } else {
      return null;
    }
  }

  ///查询所有规则
  ///[isEffect] 是否生效
  Future<List<DBRuleBean>> queryAll({bool? isEffect}) async {
    Database db = await getDB();
    late List<Map<String, dynamic>> maps;
    if(isEffect == null){
      maps = await db.query(_tableName);
    }else{
      maps = await db.query(_tableName,
          where: "$_isEffect = ?", whereArgs: [isEffect ? 1 : 0]);
    }
    return List.generate(maps.length, (i) {
      return DBRuleBean.fromJson(maps[i]);
    });
  }

  ///更新规则
  Future<DBRuleBean> update(DBRuleBean dbRuleBean) async {
    Database db = await getDB();
    await db.update(
      _tableName,
      dbRuleBean.toJson(),
      where: "$_tableId = ?",
      whereArgs: [dbRuleBean.id],
    );
    return dbRuleBean;
  }

  ///删除规则
  Future<bool> delete(DBRuleBean dbRuleBean) async {
    Database db = await getDB();
    return await db.delete(
          _tableName,
          where: "$_tableId = ?",
          whereArgs: [dbRuleBean.id],
        ) ==
        1;
  }
}
