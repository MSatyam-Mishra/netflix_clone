// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../constants/constants.dart';
import '../data/data.dart';
import '../widgets/content_list.dart';

class WatchScreen extends StatefulWidget {
  WatchScreen(
      {required this.videoURL,
      required this.imageURL,
      required this.description});
  Uri videoURL;
  String imageURL;
  String description;
  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  late VideoPlayerController _videoPlayerController;
  bool isMuted = false;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.networkUrl(widget.videoURL)
      ..initialize()
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 300,
            width: screenWidth,
            child: AspectRatio(
                aspectRatio:
                    // _videoPlayerController.value.isInitialized
                    //     ?
                    _videoPlayerController.value.aspectRatio
                // : 2.344,
                ,
                child:
                    // _videoPlayerController.value.isInitialized
                    //     ?
                    VideoPlayer(_videoPlayerController)
                // : Image.asset(widget.imageURL)
                ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Image.asset("assets/images/netflix_logo0.png"),
                Text(
                  "Series",
                  style: type,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SizedBox(
                  width: screenWidth, child: Text("Wednesday", style: name))),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: SizedBox(
          //       width: screenWidth,
          //       height: 28,
          //       child: Row(
          //         children: [
          //           Icon(
          //             Icons.favorite_rounded,
          //             color: buttonColor1,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Text(
          //             "2023",
          //             style: txtsss,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Icon(
          //             Icons.filter_9,
          //             color: buttonColor1,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Text(
          //             "1 Season",
          //             style: txtsss,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Icon(
          //             Icons.hd_rounded,
          //             color: buttonColor1,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Icon(
          //             Icons.closed_caption,
          //             color: buttonColor1,
          //           ),
          //         ],
          //       )),
          // ),

          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: screenWidth,
              height: 48,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                icon: Icon(
                  _videoPlayerController.value.isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  _videoPlayerController.value.isPlaying ? "Pause" : "Play",
                  style: playButtonTextStyle,
                ),
                onPressed: () {
                  setState(() {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
              width: screenWidth,
              height: 48,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 97, 97, 97))),
                icon: Icon(
                  Icons.file_download_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                label: Text(
                  "Download",
                  style: menuTextStyle1,
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text("Wednesday trailer", style: sectionTitleTextStyle),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(widget.description, style: txtsss),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ContnetList(
            title: "Similar Shows",
            contentList: myList,
            key: PageStorageKey('MyList'),
          ),
        ]),
      ),
    );
  }
}
