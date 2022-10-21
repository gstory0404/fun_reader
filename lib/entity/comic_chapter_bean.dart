/// @Author: gstory
/// @CreateDate: 2022/10/21 17:13
/// @Email gstory0404@gmail.com
/// @Description: 漫画章节内容

class ComicChapterContent {
  String chapterName = "";
  String chapterUrl = "";
  List<String?> contents = [];

  ComicChapterContent(
      {required this.chapterName,
      required this.chapterUrl,
      required this.contents});
}
