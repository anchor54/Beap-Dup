import 'package:flutter/material.dart';
import 'package:jpshua/constants/my_theme.dart';
import 'package:jpshua/model/user_follow_model.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/widgets/appbar/cancelable_titlebar.dart';
import 'package:jpshua/widgets/atom/search_field.dart';
import 'package:jpshua/widgets/friend_visibility_select_list.dart';

class SelectFriendsScreen extends StatefulWidget {
  final List<UserFollowModel>? followers;
  final List<UserFollowModel>? selectedFollowers;

  final Function(List<UserFollowModel>)? onFriendsSelected;

  const SelectFriendsScreen(
      {super.key, this.followers, this.onFriendsSelected, this.selectedFollowers});

  @override
  _SelectFriendsScreenState createState() => _SelectFriendsScreenState(selectedFollowers);
}

class _SelectFriendsScreenState extends State<SelectFriendsScreen> {
  List<UserFollowModel> _selectedFriends = [];
  List<UserFollowModel> _unselectedFriends = [];

  _SelectFriendsScreenState(List<UserFollowModel>? selectedFollowers) {
    if (selectedFollowers != null) {
      _selectedFriends.addAll(selectedFollowers);
    }
  }

  void _onFriendSelected(UserFollowModel friend) {
    setState(() {
      _selectedFriends.add(friend);

      _unselectedFriends.remove(friend);
    });
  }

  void _onFriendDeselected(UserFollowModel friend) {
    setState(() {
      _selectedFriends.remove(friend);

      _unselectedFriends.add(friend);
    });
  }

  void _clearAll() {
    setState(() {
      _unselectedFriends.addAll(_selectedFriends);

      _selectedFriends.clear();
    });
  }

  void _selectAll() {
    setState(() {
      _selectedFriends.addAll(_unselectedFriends);

      _unselectedFriends.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    _unselectedFriends.addAll(widget.followers ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              CancelableTitlebar(title: "Custom"),
              widget.spaceY(extra: 34),
              SearchField(
                onSearch: (value) {},
                onChanged: (value) {},
                title: "",
                enabled: widget.followers?.isNotEmpty ?? false,
              ),
              widget.spaceY(extra: 34),
              if (_selectedFriends.isNotEmpty)
                FriendVisibilitySelectList(
                  title: '${_selectedFriends.length} Person',
                  friends: _selectedFriends,
                  onFriendSelected: _onFriendDeselected,
                  isSelected: true,
                  btnText: "Clear all",
                  onBtnPressed: _clearAll,
                ),
              if (_unselectedFriends.isNotEmpty)
                FriendVisibilitySelectList(
                  title: 'Suggested',
                  friends: _unselectedFriends,
                  onFriendSelected: _onFriendSelected,
                  isSelected: false,
                  btnText: "Select all",
                  onBtnPressed: _selectAll,
                ),
            ]),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 12.0, bottom: 20.0),
                child: TextButton(
                    child: Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: _selectedFriends.isNotEmpty
                        ? () {
                            widget.onFriendsSelected?.call(_selectedFriends);
                            Navigator.of(context).pop();
                          }
                        : null,
                    style: TextButton.styleFrom(
                      backgroundColor: _selectedFriends.isNotEmpty
                          ? MyColor.themeBlue
                          : MyColor.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
