class RuleBean {
  String? sourceName;
  String? sourceUrl;
  String? head;
  List<Recommend>? recommend;
  RecommendBooks? recommendBooks;
  Search? search;
  SearchBooks? searchBooks;
  BookInfo? bookInfo;
  Chapter? chapter;
  ChapterContent? chapterContent;
  int? type;

  RuleBean({
    this.sourceName,
    this.sourceUrl,
    this.head,
    this.recommend,
    this.recommendBooks,
    this.search,
    this.searchBooks,
    this.bookInfo,
    this.chapter,
    this.chapterContent,
    this.type,
  });

  RuleBean.fromJson(Map<String, dynamic> json) {
    sourceName = json['sourceName'];
    sourceUrl = json['sourceUrl'];
    head = json['head'];
    type = json['type'];
    if (json['recommend'] != null) {
      recommend = <Recommend>[];
      json['recommend'].forEach((v) {
        recommend!.add(Recommend.fromJson(v));
      });
    }
    recommendBooks = json['recommendBooks'] != null
        ? RecommendBooks.fromJson(json['recommendBooks'])
        : null;
    search = json['search'] != null ? Search.fromJson(json['search']) : null;
    searchBooks = json['searchBooks'] != null
        ? SearchBooks.fromJson(json['searchBooks'])
        : null;
    bookInfo =
        json['bookInfo'] != null ? BookInfo.fromJson(json['bookInfo']) : null;
    chapter =
        json['chapter'] != null ? Chapter.fromJson(json['chapter']) : null;
    chapterContent = json['chapterContent'] != null
        ? ChapterContent.fromJson(json['chapterContent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourceName'] = sourceName;
    data['sourceUrl'] = sourceUrl;
    data['head'] = head;
    data['type'] = type;
    if (recommend != null) {
      data['recommend'] = recommend!.map((v) => v.toJson()).toList();
    }
    if (recommendBooks != null) {
      data['recommendBooks'] = recommendBooks!.toJson();
    }
    if (search != null) {
      data['search'] = search!.toJson();
    }
    if (searchBooks != null) {
      data['searchBooks'] = searchBooks!.toJson();
    }
    if (bookInfo != null) {
      data['bookInfo'] = bookInfo!.toJson();
    }
    if (chapter != null) {
      data['chapter'] = chapter!.toJson();
    }
    if (chapterContent != null) {
      data['chapterContent'] = chapterContent!.toJson();
    }
    return data;
  }
}

class Recommend {
  String? recommendName;
  String? recommendUrl;

  Recommend({this.recommendName, this.recommendUrl});

  Recommend.fromJson(Map<String, dynamic> json) {
    recommendName = json['recommendName'];
    recommendUrl = json['recommendUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recommendName'] = recommendName;
    data['recommendUrl'] = recommendUrl;
    return data;
  }
}

class RecommendBooks {
  String? books;
  String? name;
  String? author;
  String? cover;
  String? intro;
  String? category;
  String? lastChapter;
  String? bookUrl;

  RecommendBooks(
      {this.books,
      this.name,
      this.author,
      this.cover,
      this.intro,
      this.category,
      this.lastChapter,
      this.bookUrl});

  RecommendBooks.fromJson(Map<String, dynamic> json) {
    books = json['books'];
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    intro = json['intro'];
    category = json['category'];
    lastChapter = json['lastChapter'];
    bookUrl = json['bookUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['books'] = books;
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

class Search {
  String? url;
  String? method;
  String? body;
  String? contentType;

  Search({this.url, this.method, this.body, this.contentType});

  Search.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    method = json['method'];
    body = json['body'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['method'] = method;
    data['body'] = body;
    data['contentType'] = contentType;
    return data;
  }
}

class SearchBooks {
  String? books;
  String? name;
  String? author;
  String? cover;
  String? intro;
  String? category;
  String? lastChapter;
  String? bookUrl;

  SearchBooks(
      {this.books,
      this.name,
      this.author,
      this.cover,
      this.intro,
      this.category,
      this.lastChapter,
      this.bookUrl});

  SearchBooks.fromJson(Map<String, dynamic> json) {
    books = json['books'];
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    intro = json['intro'];
    category = json['category'];
    lastChapter = json['lastChapter'];
    bookUrl = json['bookUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['books'] = books;
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

class BookInfo {
  String? name;
  String? author;
  String? cover;
  String? intro;
  String? category;
  String? lastChapter;
  String? chapterUrl;
  String? updateTime;

  BookInfo(
      {this.name,
      this.author,
      this.cover,
      this.intro,
      this.category,
      this.lastChapter,
      this.chapterUrl,
      this.updateTime});

  BookInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    author = json['author'];
    cover = json['cover'];
    intro = json['intro'];
    category = json['category'];
    lastChapter = json['lastChapter'];
    chapterUrl = json['chapterUrl'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['author'] = author;
    data['cover'] = cover;
    data['intro'] = intro;
    data['category'] = category;
    data['lastChapter'] = lastChapter;
    data['chapterUrl'] = chapterUrl;
    data['updateTime'] = updateTime;
    return data;
  }
}

class Chapter {
  String? chapterList;
  String? chapterName;
  String? nextPage;
  String? chapterUrl;

  Chapter({this.chapterList, this.chapterName, this.nextPage, this.chapterUrl});

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterList = json['chapterList'];
    chapterName = json['chapterName'];
    chapterUrl = json['chapterUrl'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapterList'] = chapterList;
    data['chapterName'] = chapterName;
    data['chapterUrl'] = chapterUrl;
    data['nextPage'] = nextPage;
    return data;
  }
}

class ChapterContent {
  String? content;
  String? nextPage;
  String? replaceReg;

  ChapterContent({this.content, this.nextPage, this.replaceReg});

  ChapterContent.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    nextPage = json['nextPage'];
    replaceReg = json['replaceReg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['nextPage'] = nextPage;
    data['replaceReg'] = replaceReg;
    return data;
  }
}
