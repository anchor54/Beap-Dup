import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/view_model/profile_vm.dart';
import 'package:provider/provider.dart';

class SelectableFriendsList extends StatelessWidget {
  final List<UserFollowModel> friendsList;

  final Function(String?) onSelected;

  final Function(String?) onDeselected;

  final Function() onAddFriends;

  const SelectableFriendsList(
      {super.key,
      required this.friendsList,
      required this.onSelected,
      required this.onDeselected,
      required this.onAddFriends});

  @override
  Widget build(BuildContext context) {
    List<String?> selectedFriendIds = context.watch<ProfileVM>().selectedFriendIds;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, controller) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: controller, // ensure the ListView can be scrolled
              scrollDirection: Axis.vertical,
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  checkColor: Colors.black,
                  title: Text(friendsList[index].name ?? '<NULL>',
                      style: TextStyle(
                        fontSize: 18,
                        color: MyColor.secondary,
                      )),
                  subtitle: Text('@${friendsList[index].userName}',
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColor.onSecondary,
                      )),
                  value: selectedFriendIds.contains(friendsList[index].uId),
                  onChanged: (bool? value) {
                    if (value == true) {
                      onSelected(friendsList[index].uId);
                    } else {
                      onDeselected(friendsList[index].uId);
                    }
                  },
                );
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(4),
              child: TextButton(
                onPressed: onAddFriends,
                child: Text('Add Friends'),
                style: TextButton.styleFrom(
                  backgroundColor: MyColor.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: MyColor.primary,
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
              )
          ),
        ],
      ),
    );
  }
}
