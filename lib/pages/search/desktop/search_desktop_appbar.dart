import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fun_reader/entity/db_rule_bean.dart';
import 'package:fun_reader/lang/keys.dart';
import 'package:fun_reader/pages/search/search_ctr.dart';
import 'package:get/get.dart';

/// @Author: gstory
/// @CreateDate: 2022/6/14 11:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchDesktopAppbar extends GetView<SearchCtr>
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      titleSpacing: 0,
      elevation: 0,
      leading: Container(),
      leadingWidth: 10,
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
              child: Icon(
                Icons.search,
                size: 22,
                color: Colors.black,
              ),
            ),
            Container(
              width: 80,
              margin: const EdgeInsets.only(left: 4),
              child: DropdownButtonHideUnderline(
                child: GetBuilder<SearchCtr>(
                  builder: (controller) {
                    return DropdownButton2(
                      isExpanded: true,
                      items: controller.types
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ))
                          .toList(),
                      value: controller.types[controller.choose - 1],
                      onChanged: (value) {
                        controller.changeType(value.toString());
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 18,
                      ),
                      iconSize: 12,
                      iconEnabledColor: Colors.black26,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: 120,
                      buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 1),
                      dropdownMaxHeight: 300,
                      dropdownWidth: 100,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(20),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, -4),
                    );
                  },
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
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: Keys.searchHint.tr,
                  hintStyle:
                      const TextStyle(fontSize: 15, color: Color(0xFF999999)),
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
        CloseButton(
          onPressed: () {
            controller.inputController.clear();
          },
          color: Colors.black,
        )
      ],
    );
  }
}
