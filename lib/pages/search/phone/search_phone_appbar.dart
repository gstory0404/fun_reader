import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 11:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPhoneAppbar extends GetView<SearchCtr>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: BackButton(onPressed: () {
        Get.back();
      }),
      title: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: Icon(Icons.search, size: 22, color: Color(0xFF999999)),
            ),
            Container(
              width: 80,
              margin: const EdgeInsets.only(left: 4),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton2(
                    isExpanded: true,
                    hint: const Text(
                      '选择书源',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    items: controller.ruleList
                        .map((item) => DropdownMenuItem<DBRuleBean>(
                              value: item,
                              child: Text(
                                item.sourceName ?? "未知",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ),
                            ))
                        .toList(),
                    value: controller.rule.value,
                    onChanged: (value) {
                      controller.changeRule(value as DBRuleBean);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 18,
                    ),
                    iconSize: 12,
                    iconEnabledColor: Colors.black26,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 300,
                    dropdownWidth: 260,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(20),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(-20, 0),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 18,
              margin: EdgeInsets.symmetric(horizontal: 4),
              color: Color(0xFF999999),
            ),
            Expanded(
              child: TextField(
                // autofocus: widget.autoFocus,
                // focusNode: _focusNode,
                controller: controller.inputController,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: '请输入小说、作者',
                  hintStyle: TextStyle(fontSize: 15, color: Color(0xFF999999)),
                ),
                style: const TextStyle(
                    fontSize: 15, color: Color(0xFF333333), height: 1),
                textInputAction: TextInputAction.search,
                onTap: () {},
                onSubmitted: (key) {
                  controller.searchBook(key);
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        CloseButton(onPressed: () {
          controller.inputController.clear();
        })
      ],
    );
  }
}
