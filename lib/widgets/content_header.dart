import 'package:Netflix/models/content_model.dart';
import 'package:Netflix/screens/watch_screen.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({super.key, required this.featuredContent});
  void tap() {
    print("button is clicked!");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(featuredContent.imageUrl),
                  fit: BoxFit.cover)),
        ),
        Container(
          height: 500.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: overlayGradient,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(
              featuredContent.titleImageUrl,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                VerticalIconButton(
                    icon: Icons.add_rounded, title: "List", onTap: tap),
                PlayButton(
                  videoUrl: Uri.parse(featuredContent.videoUrl),
                  imageURL: featuredContent.imageUrl,
                  description: featuredContent.description,
                ),
                VerticalIconButton(
                    icon: Icons.info_outline_rounded, title: "Info", onTap: tap)
              ],
            ))
      ],
    );
  }
}

class VerticalIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const VerticalIconButton(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(height: 2),
        Text(
          title,
          style: verticalbuttonTextStyle,
        ),
      ]),
      onTap: () {
        onTap;
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  Uri videoUrl;
  String imageURL;
  String description;
  PlayButton(
      {required this.videoUrl,
      required this.imageURL,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WatchScreen(
                    description: description,
                    imageURL: imageURL,
                    videoURL: videoUrl,
                  ))),
      icon: Icon(
        Icons.play_arrow_rounded,
        color: Colors.black,
        size: 30,
      ),
      label: Text(
        "Play",
        style: playButtonTextStyle,
      ),
    );
  }
}
