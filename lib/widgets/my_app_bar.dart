import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MyAppBar extends StatelessWidget {
  final double scrollOffset;
  const MyAppBar({super.key, this.scrollOffset = 0.0});

  @override
  Widget build(BuildContext context) {
    void tap() {
      print("button is clicked!");
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color:
          Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
          child: Row(children: [
        Image.asset("assets/images/netflix_logo0.png"),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AppBarButtonWidget(buttonTitle: "TV Shows", onTap: tap),
              _AppBarButtonWidget(buttonTitle: "Movies", onTap: tap),
              _AppBarButtonWidget(buttonTitle: "My List", onTap: tap),
            ],
          ),
        )
      ])),
    );
  }
}

class SearchScreenAppBar extends StatefulWidget {
  final double scrollOffset;
  SearchScreenAppBar(
      {super.key,
      this.scrollOffset = 0.0,
      required this.searchMethod,
      required this.searchText});

  String searchText;
  Future<dynamic> Function() searchMethod;

  @override
  State<SearchScreenAppBar> createState() => _SearchScreenAppBarState();
}

class _SearchScreenAppBarState extends State<SearchScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: Colors.black
          .withOpacity((widget.scrollOffset / 350).clamp(0, 1).toDouble()),
      child: SafeArea(
          child: TextField(
        onChanged: (value) {
          setState(() {
            widget.searchText = value;
          });
        },
        onSubmitted: (value) async {
          await widget.searchMethod();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 10,
              color: Colors.white,
            ),
          ),
          hintText: 'Search',
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              await widget.searchMethod();
            },
          ),
        ),
      )),
    );
  }
}

class _AppBarButtonWidget extends StatelessWidget {
  final String buttonTitle;
  final Function onTap;

  const _AppBarButtonWidget(
      {super.key, required this.buttonTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap;
      },
      child: Text(buttonTitle, style: menuTextStyle1),
    );
  }
}
