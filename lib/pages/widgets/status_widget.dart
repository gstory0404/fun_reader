import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/23 10:24
/// @Email gstory0404@gmail.com
/// @Description: 加载页面

//定义枚举类型
enum LoadType { main, loading, error, empty }

class StatusWidget extends StatefulWidget {
  LoadType loadType;
  Widget body;

  StatusWidget({Key? key, required this.loadType, required this.body})
      : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.loadType == LoadType.loading) {
      return _loadWidget(context);
    } else if (widget.loadType == LoadType.error) {
      return _errorWidget(context);
    } else if (widget.loadType == LoadType.empty) {
      return _emptyWidget(context);
    } else {
      return widget.body;
    }
  }

  ///加载页面
  Widget _loadWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitSpinningLines(
            color: Color(0xFF12aa9c),
            size: 50,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              Keys.loadingTips.tr,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  ///空页面
  Widget _emptyWidget(BuildContext context) {
    return Center(
      child: Text(
        Keys.emptyTips.tr,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }

  ///错误页面
  Widget _errorWidget(BuildContext context) {
    return Center(
      child: Text(
        Keys.errorTips.tr,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
    );
  }
}
