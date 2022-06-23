# FunReader数据采集规则说明

[示例](https://github.com/gstory0404/fun_reader/blob/master/file/spider.json)


```
[
  {
    "sourceName": "",
    "sourceUrl": "",
    "head": "",
    "recommend": [
      {
        "recommendName": "",
        "recommendUrl": ""
      }
    ],
    "recommendBooks": {
      "books": "",
      "name": "",
      "author": "",
      "cover": "",
      "intro": "",
      "category": "",
      "lastChapter": "",
      "bookUrl": ""
    },
    "search": {
      "url": "",
      "method": "",
      "body": "{\"searchkey\":\"&key&\"}",
      "contentType": ""
    },
    "searchBooks": {
      "books": "",
      "name": "",
      "author": "",
      "cover": "",
      "intro": "",
      "category": "",
      "lastChapter": "",
      "bookUrl": ""
    },
    "bookInfo": {
      "name": "",
      "author": "",
      "cover": "",
      "intro": "",
      "category": "",
      "lastChapter": "",
      "updateTime": "",
      "chapterUrl": ""
    },
    "chapter": {
      "chapterList": "",
      "chapterName": "",
      "chapterUrl": "",
      "nextPage": ""
    },
    "chapterContent": {
      "content": "",
      "nextPage": "",
      "replaceReg": ""
    }
  }
]
```

数据均通过xptah规则进行提取！

## sourceName
书源名称

## sourceUrl
书源域名

## head
请求头部参数，如"{\"abc\":\"a\"}"

## recommend
推荐列表
|  字段   | 说明  |
|  ----  | ----  |
|  recommendName  | 推荐栏目名称  |
|  recommendUrl  | 推荐栏目链接  |



## recommendBooks
推荐栏目书籍列表

|  字段   | 说明  |
|  ----  | ----  |
|  books  | 推荐栏目书籍列表集合，如果存在翻页则固定&page&为页码  |
|  name  | 集合item中解析书名  |
|  author  | 集合item中解析作者  |
|  cover  | 集合item中解析封面  |
|  intro  | 集合item中解析简介  |
|  category  | 集合item中解析分类  |
|  lastChapter  | 集合item中解析最后一章名称  |
|  bookUrl  | 集合item中解析书籍链接  |

## search
搜索

|  字段   | 说明  |
|  ----  | ----  |
|  url  | 链接  |
|  method  | 请求方式  |
|  body  | post时需要传入的参数，"{\"searchkey\":\"&key&\"，搜索关键字为&key&固定写法  |
|  contentType  | 请求头contentType  |

## searchBooks
搜索小说列表

|  字段   | 说明  |
|  ----  | ----  |
|  books  | 推荐栏目书籍列表集合  |
|  name  | 集合item中解析书名  |
|  author  | 集合item中解析作者  |
|  cover  | 集合item中解析封面  |
|  intro  | 集合item中解析简介  |
|  category  | 集合item中解析分类  |
|  lastChapter  | 集合item中解析最后一章名称  |
|  bookUrl  | 集合item中解析书籍链接  |

## bookInfo
书籍详情

|  字段   | 说明  |
|  ----  | ----  |
|  name  | 书名  |
|  author  | 作者  |
|  cover  | 封面  |
|  intro  | 简介  |
|  category  | 分类  |
|  lastChapter  | 最后一章名称  |
|  updateTime  | 更新时间  |
|  chapterUrl  | 所有章节列表链接（如果不为空则从解析的url中获取，如果空则在当前页面解析）  |

## chapter
章节解析规则
|  字段   | 说明  |
|  ----  | ----  |
|  chapterList  | 章节列表集合  |
|  chapterName  | 集合item解析章节名称  |
|  chapterUrl  | 集合item解析章节url  |
|  nextPage  | 下一页url，如果不为空则循环获取所有章节|

## chapterContent
章节内容规则
|  字段   | 说明  |
|  ----  | ----  |
|  content  | 章节内容  |
|  nextPage  | 下一个xpath,如果不为空则循环获取下一页面  |
|  replaceReg  | 正则替换内容  |
