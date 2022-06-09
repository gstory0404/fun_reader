/// @Author: gstory
/// @CreateDate: 2022/6/9 15:44
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class CategoryBookEntity {
  String title = "";
  String author = "";
  String content = "";
  String logo = "";
  String id = "";

  CategoryBookEntity({required this.title,required this.author,required this.content,required this.logo,required this.id});

  CategoryBookEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    author = json['author'];
    content = json['content'];
    logo = json['logo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['author'] = author;
    data['content'] = content;
    data['logo'] = logo;
    data['id'] = id;
    return data;
  }
}



