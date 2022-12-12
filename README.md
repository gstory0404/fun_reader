
<p align="center">
    <br>
    <img src="https://github.com/gstory0404/fun_reader/blob/master/assets/images/logo.png" width="120"/>
    <br>
    FunReader
<p>

开源小说、漫画阅读器，支持android、ios、window、macos、linux多平台运行，支持自定义书源，支持多语言。

> 本项目仅供学习交流，请勿用于商业用途！！

# 主要功能

- 自定义书源导入
- 小说搜索
- 小说分类查看
- 小说阅读
- 漫画搜索
- 漫画分类查看
- 漫画阅读
- 书架管理
- 多语言支持

## 预览

|  macos   | android  |
|  ----  | ----  |
| <img src="https://github.com/gstory0404/fun_reader/blob/master/file/macos.gif" width="360px" height="400px"/>   | <img src="https://github.com/gstory0404/fun_reader/blob/master/file/phone.gif" width="210px" height="400px"/> |


## 书源规则
 
[书源规则](https://github.com/gstory0404/fun_reader/blob/master/rule.md)

## 打包
打包前需要查看文档配置[运行环境](https://docs.flutter.dev/deployment/android)

- Android
```shell
flutter build apk
```

- iOS
```shell
flutter build ipa
```

- Windows
需要再window环境中编译
```shell
flutter build windows
```

- macOS
需要再macOS环境中编译
```shell
flutter build macos
```

- linux
需要再linux环境中编译
```shell
snap install --classic flutter
snap install --classic code
code --install-extension dart-code.flutter
flutter build linux
```




