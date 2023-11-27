import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/utils/extensions/theme_extension.dart';
import 'package:jpshua/widgets/atom/search_field.dart';

import '../../constants/my_theme.dart';

class SearchableOtherUserList extends StatelessWidget {
  final String title;
  final List<UserFollowModel> userList;
  final Widget Function(UserFollowModel) userItem;
  final Function(String) onSearch;

  SearchableOtherUserList(
      {super.key,
      required this.title,
      required this.userList,
      required this.userItem,
      required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            onSearch: onSearch,
            onChanged: onSearch,
          ),
          spaceY(extra: 20),
          // viewModel.searchController.text.isEmpty?
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: userList.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: userList.length,
                    primary: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return userItem(userList[index]);
                    },
                    separatorBuilder: (BuildContext context, int i) {
                      return spaceY(extra: 20.0);
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        Center(
                          child: Text("No ${title} yet",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: context.theme.onPrimary,
                                  fontWeight: FontWeight.w500)),
                        ),
                        spaceY(extra: 2),
                        Center(
                          child: Text(
                              "You do not have any ${title.toLowerCase()} on Beap.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: context.theme.onSecondary,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
          ))
        ],
      ),
    );
  }
}
