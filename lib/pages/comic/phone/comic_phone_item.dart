import 'package:flutter/material.dart';
import 'package:fun_reader/entity/comic_chapter_bean.dart';

/// @Author: gstory
/// @CreateDate: 2022/10/21 17:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ComicPhoneItem extends StatelessWidget {
  ComicChapterContent content;

  ComicPhoneItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 0),
          alignment: Alignment.centerLeft,
          child: Text(
            content.chapterName,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
        ),
        ListView.builder(
          itemCount: content.contents.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Image.network(content.contents[index] ?? "");
          },
        ),
      ],
    );
  }
}
