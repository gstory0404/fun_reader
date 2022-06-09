/// @Author: gstory
/// @CreateDate: 2022/6/9 11:18
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 

class SpiderBean {
  String? name;
  String? url;
  String? type;
  Category? category;

  SpiderBean({this.name, this.url, this.type, this.category});

  SpiderBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    type = json['type'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['type'] = this.type;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  String? url;
  String? bookName;
  String? author;
  String? content;
  String? logo;
  String? id;
  String? categoryName;
  String? categoryId;
  String? nextId;
  String? lastId;

  Category(
      {this.url,
        this.bookName,
        this.author,
        this.content,
        this.logo,
        this.id,
        this.categoryName,
        this.categoryId,
        this.nextId,
        this.lastId});

  Category.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    bookName = json['bookName'];
    author = json['author'];
    content = json['content'];
    logo = json['logo'];
    id = json['id'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    nextId = json['nextId'];
    lastId = json['lastId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['bookName'] = this.bookName;
    data['author'] = this.author;
    data['content'] = this.content;
    data['logo'] = this.logo;
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    data['nextId'] = this.nextId;
    data['lastId'] = this.lastId;
    return data;
  }
}


