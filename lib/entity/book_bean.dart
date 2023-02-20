class BookBean {
  String? name;
  String? author;
  String? cover;
  String? intro;
  List<String?>? category;
  String? lastChapter;
  String? bookUrl;

  BookBean(
      {this.name,
      this.author,
      this.cover,
      this.intro,
      this.category,
      this.lastChapter,
      this.bookUrl});

  BookBean.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    intro = json['intro'];
    category = json['category'].cast<String>();
    lastChapter = json['lastChapter'];
    bookUrl = json['bookUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['author'] = author;
    data['cover'] = cover;
    data['intro'] = intro;
    data['category'] = category;
    data['lastChapter'] = lastChapter;
    data['bookUrl'] = bookUrl;
    return data;
  }
}
