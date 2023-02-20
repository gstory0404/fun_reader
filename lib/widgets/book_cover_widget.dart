import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/15 10:56
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class BookCoverWidget extends StatelessWidget{

  String cover;
  double width;
  double height;

  BookCoverWidget(this.cover,{required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder: const AssetImage(
        "assets/images/icon_book_logo.png",
      ),
      image: NetworkImage(cover),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/icon_book_logo.png",
          width: width,
          height: height,
          fit: BoxFit.fill,
        );
      },
    );
  }

}

