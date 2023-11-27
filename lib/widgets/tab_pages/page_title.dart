import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final Function(int) onTap;
  final int selectedPage;
  final List<String> titles;
  final Color activeColor;
  final Color inactiveColor;
  final double fontSize;
  final FontWeight fontWeight;

  const PageTitle(
      {Key? key,
      required this.titles,
      required this.onTap,
      required this.selectedPage,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.grey,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemCount = titles.length;

    return Container(
      height: 55,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth = (itemCount > 3) ? constraints.maxWidth / 3 : 100.0;
          return ListView(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      titles.length,
                      (index) => InkWell(
                            onTap: () {
                              onTap(index);
                            },
                            child: SizedBox(
                              width: itemWidth,
                              child: Center(
                                  child: Text(
                                titles[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedPage == index
                                      ? activeColor
                                      : inactiveColor,
                                  fontWeight: fontWeight,
                                  fontSize: fontSize
                                ),
                              )),
                            ),
                          )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
