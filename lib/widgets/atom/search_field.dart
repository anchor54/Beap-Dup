import 'package:flutter/material.dart';


import 'package:flutter_svg/svg.dart';


import 'package:jpshua/utils/extensions/theme_extension.dart';


class SearchField extends StatelessWidget {

  final bool? enabled;


  final Function(String) onSearch;


  final Function(String) onChanged;


  final String? title;


  const SearchField(

      {super.key,

      required this.onSearch,

      required this.onChanged,

      this.title,

      this.enabled = true});


  @override

  Widget build(BuildContext context) {

    return Container(
        decoration: BoxDecoration(
          color: Color(0xFFEAEAEA),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          child: TextFormField(
            textAlign: TextAlign.start,

            enabled: this.enabled,

            // controller:viewModel.searchController,

            style: TextStyle(fontSize: 14, color: context.theme.onPrimary),

            cursorColor: context.theme.onPrimary,

            onFieldSubmitted: (value) {
              onSearch(value);
            },

            onChanged: (value) {
              onSearch(value);
            },

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.transparent,
              enabled: true,
              hintText: "Search ${title?.toLowerCase() ?? ''}",
              prefixIcon: IconButton(
                icon: SvgPicture.asset(
                  height: 15,
                  width: 15,
                  "assets/svg/search.svg",
                ),
                onPressed: () {},
              ),
              hintStyle: TextStyle(
                  color: context.theme.onSecondary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ));

  }

}

