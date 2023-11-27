import 'package:flutter/material.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';

import '../../constants/my_theme.dart';

class TabTitle extends StatelessWidget {
  final List<String> titles;
  final int selectedIdx;
  final Function(int) onTap;

  TabTitle(
      {required this.titles,
      required this.selectedIdx,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    final itemCount = titles.length;
    final itemWidth = itemCount >= 3
        ? MediaQuery.of(context).size.width / 3
        : MediaQuery.of(context).size.width / itemCount;

    return Container(
      height: 37,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: context.theme.secondary, width: 0.5))),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              onTap(index);
            },
            child: Container(
              width: itemWidth,
              padding: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: selectedIdx == index
                              ? MyColor.onPrimary
                              : Colors.transparent,
                          width: 1))),
              child: Center(
                  child: Text(
                titles[index],
                style: TextStyle(
                  color: selectedIdx == index
                      ? Colors.black
                      : const Color(0xFF666666),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
