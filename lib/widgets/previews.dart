import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../data/apis/api_value.dart';
import '../models/content_model.dart';
import '../screens/details_screen.dart';

class Previews extends StatefulWidget {
  final String title;
  const Previews({
    super.key,
    required this.title,
  });

  @override
  State<Previews> createState() => _PreviewsState();
}

class _PreviewsState extends State<Previews> {
  List allMovieList = [];

  Future<dynamic> fetchAllMovies() async {
    var data = await ApiValue().fetchShows();
    print(data);
    setState(() {
      allMovieList = data;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            widget.title,
            style: sectionTitleTextStyle,
          ),
        ),
        Container(
            height: 175,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: allMovieList.length,
                itemBuilder: (BuildContext context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                            index: i,
                            movieList: allMovieList,
                          );
                        }),
                      );
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        height: 135,
                        width: 135,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 3.5, color: Colors.white),
                          image: DecorationImage(
                            image: NetworkImage(
                              allMovieList[i]['show']['image']['medium'] == null
                                  ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                  : allMovieList[i]['show']['image']['medium'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 135,
                        width: 135,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3.5, color: Colors.white),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.black45,
                                  Colors.transparent
                                ],
                                stops: [
                                  0,
                                  0.25,
                                  1
                                ])),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: 65,
                            child: Center(
                              child: Text(
                                allMovieList[i]['show']['name'],
                                style: sectionTitleTextStyle,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ]),
                  );
                })),
      ],
    );
  }
}
