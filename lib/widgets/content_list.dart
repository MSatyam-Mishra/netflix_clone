import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/content_model.dart';

class ContnetList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOrignals;
  const ContnetList(
      {super.key,
      required this.title,
      required this.contentList,
      this.isOrignals = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            title,
            style: sectionTitleTextStyle,
          ),
        ),
        Container(
          height: isOrignals ? 500 : 225,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contentList.length,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemBuilder: (context, index) {
              final Content content = contentList[index];
              return GestureDetector(
                onTap: () => print("printing"),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(05),
                      image: DecorationImage(
                          image: AssetImage(content.imageUrl),
                          fit: BoxFit.cover)),
                  height: isOrignals ? 400 : 200,
                  width: isOrignals ? 250 : 125,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
