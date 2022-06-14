import 'package:flutter/material.dart';
import 'package:fun_novel/entity/rule_bean.dart';
import 'package:fun_novel/routes/app_pages.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/13 16:27
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class FindItem extends StatefulWidget {
  RuleBean ruleBean;

  FindItem({Key? key, required this.ruleBean}) : super(key: key);

  @override
  State<FindItem> createState() => _FindItemState();
}

class _FindItemState extends State<FindItem> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (mounted) {
                setState(() {
                  isShow = !isShow;
                });
              }
            },
            child: Container(
              color: Colors.black12,
              margin: const EdgeInsets.only(bottom: 2),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      widget.ruleBean.sourceName ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  isShow
                      ? const Icon(
                          Icons.expand_more,
                          size: 16,
                        )
                      : const Icon(
                          Icons.expand_less,
                          size: 16,
                        ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isShow,
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 10.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.start,
                children: widget.ruleBean.recommend?.map((e) => _getRecommendItem(e)).toList() ?? [],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getRecommendItem(Recommend recommend) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CATRGORY, arguments: {
          "name": recommend.recommendName,
          "sourceUrl": widget.ruleBean.sourceUrl,
          "path": recommend.recommendUrl
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black12,
        ),
        child: Text(recommend.recommendName ?? ""),
      ),
    );
  }
}
