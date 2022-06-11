/// @Author: gstory
/// @CreateDate: 2022/6/11 14:32
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class ChapterBean{
  String? name;
  String? id;

  ChapterBean({this.name, this.id});

  ChapterBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    return data;
  }
}

