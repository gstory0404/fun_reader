/// @Author: gstory
/// @CreateDate: 2022/6/11 14:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ChapterBean{
  String? chapterName;
  String? chapterUrl;

  ChapterBean({this.chapterName, this.chapterUrl});

  ChapterBean.fromJson(Map<String, dynamic> json) {
    chapterName = json['chapterName'];
    chapterUrl = json['chapterUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapterName'] = chapterName;
    data['chapterUrl'] = chapterUrl;
    return data;
  }
}

