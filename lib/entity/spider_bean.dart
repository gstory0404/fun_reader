/// @Author: gstory
/// @CreateDate: 2022/6/9 11:18
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
class SpiderBean {
  final String? name;
  final String? url;
  final String? type;
  final Category? category;
  final Search? search;

  SpiderBean({
    this.name,
    this.url,
    this.type,
    this.category,
    this.search,
  });

  SpiderBean.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        url = json['url'] as String?,
        type = json['type'] as String?,
        category = (json['category'] as Map<String, dynamic>?) != null
            ? Category.fromJson(json['category'] as Map<String, dynamic>)
            : null,
        search = (json['search'] as Map<String, dynamic>?) != null
            ? Search.fromJson(json['search'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
        'type': type,
        'category': category?.toJson(),
        'search': search?.toJson()
      };
}

class Category {
  final String? url;
  final String? books;
  final String? bookName;
  final String? author;
  final String? content;
  final String? logo;
  final String? id;
  final String? categorys;
  final String? categoryName;
  final String? categoryId;
  final String? nextId;
  final String? lastId;

  Category({
    this.url,
    this.books,
    this.bookName,
    this.author,
    this.content,
    this.logo,
    this.id,
    this.categorys,
    this.categoryName,
    this.categoryId,
    this.nextId,
    this.lastId,
  });

  Category.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String?,
        books = json['books'] as String?,
        bookName = json['bookName'] as String?,
        author = json['author'] as String?,
        content = json['content'] as String?,
        logo = json['logo'] as String?,
        id = json['id'] as String?,
        categorys = json['categorys'] as String?,
        categoryName = json['categoryName'] as String?,
        categoryId = json['categoryId'] as String?,
        nextId = json['nextId'] as String?,
        lastId = json['lastId'] as String?;

  Map<String, dynamic> toJson() => {
        'url': url,
        'books': books,
        'bookName': bookName,
        'author': author,
        'content': content,
        'logo': logo,
        'id': id,
        'categorys': categorys,
        'categoryName': categoryName,
        'categoryId': categoryId,
        'nextId': nextId,
        'lastId': lastId
      };
}

class Search {
  final String? url;
  final String? postKey;
  final String? books;
  final String? bookName;
  final String? author;
  final String? content;
  final String? logo;
  final String? id;

  Search({
    this.url,
    this.postKey,
    this.books,
    this.bookName,
    this.author,
    this.content,
    this.logo,
    this.id,
  });

  Search.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String?,
        postKey = json['postKey'] as String?,
        books = json['books'] as String?,
        bookName = json['bookName'] as String?,
        author = json['author'] as String?,
        content = json['content'] as String?,
        logo = json['logo'] as String?,
        id = json['id'] as String?;

  Map<String, dynamic> toJson() => {
        'url': url,
        'postKey': postKey,
        'books': books,
        'bookName': bookName,
        'author': author,
        'content': content,
        'logo': logo,
        'id': id
      };
}
