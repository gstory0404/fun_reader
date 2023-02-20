import 'package:fun_reader/entity/book_bean.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';

/// @Author: gstory
/// @CreateDate: 2023/2/20 14:18
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
///
class SearchBean {
  DBRuleBean? rule;
  List<BookBean>? books = [];

  SearchBean({this.rule, this.books});
}
