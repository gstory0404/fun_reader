import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/16 17:15
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ProgressWidget extends StatefulWidget {
  double defaultValue;
  double maxValue;
  Function(double value)? onStart;
  Function(double value)? onChange;
  Function(double value)? onFinish;

  ProgressWidget(
      {Key? key,
      required this.defaultValue,
      required this.maxValue,
      this.onStart,
      this.onChange,
      this.onFinish})
      : super(key: key);

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  var defaultValue = 0.0;

  @override
  void initState() {
    defaultValue = widget.defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:SliderTheme(
        data: const SliderThemeData(
            trackHeight:20,
          inactiveTrackColor: Colors.white70,
          activeTrackColor: Colors.red,
          thumbColor: Colors.white,
        ),
        child: Slider(
          value: defaultValue,
          max: widget.maxValue,
          onChanged: (value) {
            setState(() {
              defaultValue = value;
            });
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
          },
          onChangeStart: (value) {
            if (widget.onStart != null) {
              widget.onStart!(value);
            }
          },
          onChangeEnd: (value) {
            if (widget.onFinish != null) {
              widget.onFinish!(value);
            }
          },
        ),
      ),
    );
  }
}
