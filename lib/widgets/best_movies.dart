import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../data/apis/api_value.dart';
import '../screens/details_screen.dart';

class BestMovies extends StatefulWidget {
  final String title;
  BestMovies({super.key, required this.title});
  @override
  State<BestMovies> createState() => _BestMoviesState();
}

class _BestMoviesState extends State<BestMovies> {
  List bestMovieList = [];

  @override
  void initState() {
    super.initState();

    bestShowFetch();
  }

  Future<dynamic> bestShowFetch() async {
    var data = await ApiValue().allMovieList();

    setState(() {
      bestMovieList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            widget.title,
            style: sectionTitleTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        Container(
          height: 225,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bestMovieList.length,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  bestMovieList[i]['show']['image'] == null
                      ? print("Not Available")
                      : Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DetailsScreen(
                              index: i,
                              movieList: bestMovieList,
                            );
                          }),
                        );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    image: DecorationImage(
                      image: NetworkImage(
                        bestMovieList[i]['show']['image'] == null
                            ? 'https://cdn.pixabay.com/animation/2022/07/29/03/42/03-42-22-68_512.gif'
                            : bestMovieList[i]['show']['image']['medium'] ==
                                    null
                                ? 'https://cdn.pixabay.com/animation/2022/07/29/03/42/03-42-22-68_512.gif'
                                : bestMovieList[i]['show']['image']['medium'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                  width: 125,
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
