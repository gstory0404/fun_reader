/// @Author: gstory
/// @CreateDate: 2022/6/9 15:37
/// @Email gstory0404@gmail.com
/// @Description: 分类

class CategoryEntity {
  String name = "";
  String id = "";

  CategoryEntity({required this.name,required this.id});

  CategoryEntity.fromJson(Map<String, dynamic> json) {
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

