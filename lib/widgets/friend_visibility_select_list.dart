import 'package:flutter/material.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/widgets/choosable_friend_item.dart';

class FriendVisibilitySelectList extends StatelessWidget {
  final String title;

  final List<UserFollowModel>
      friends; // Assuming Friend is the type of your friend object

  final bool isSelected;

  final Function(UserFollowModel) onFriendSelected;

  final String? btnText;

  final Function()? onBtnPressed;

  const FriendVisibilitySelectList({
    required this.title,
    required this.friends,
    required this.onFriendSelected,
    required this.isSelected,
    this.btnText,
    this.onBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.02,
              ),
            ),
            TextButton(
                onPressed: onBtnPressed,
                child: Text(
                  btnText ?? "",
                  style: TextStyle(
                    color: Color(0xFF0C82EE),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 0.02,
                  ),
                ))
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];

            return ChoosableFriendItem(
              friendId: friend.uId ?? "",
              imageUrl: friend.image,
              title: friend.name,
              subtitle: friend.userName != null ? "@${friend.userName}" : "",
              isSelected: isSelected,
              onSelected: () => onFriendSelected(friend),
            );
          },
          // separatorBuilder: (context, index) => spaceY(extra: 10),
        ),
      ],
    );
  }
}
