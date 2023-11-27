import 'package:flutter/material.dart';
import 'package:jpshua/model/post_model.dart';
import 'package:jpshua/utils/extensions/space.dart';
import 'package:jpshua/widgets/post_card.dart';

// ignore: must_be_immutable
class HomeBody extends StatelessWidget {
  final List<PostModel> posts;

  HomeBody({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context, int i) =>
                    PostCard(post: posts[i]),
                separatorBuilder: (BuildContext context, int i) =>
                    spaceY(extra: 16.0),
                itemCount: posts.length),
          )),
    );
  }
}
