import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({super.key, required this.index, required this.movieList});
  final int index;
  final List movieList;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: DetailsHeader(
              image: widget.movieList[widget.index]['show']['image']['original']
                  .toString(),
              name: widget.movieList[widget.index]['show']['name'],
              year: widget.movieList[widget.index]['show']['premiered'],
              genres: widget.movieList[widget.index]['show']['genres'],
            ),
          ),
          SliverToBoxAdapter(
            child: RatingSection(
              imdbCode: widget.movieList[widget.index]['show']['externals']
                      ['imdb']
                  .toString(),
              weightScore:
                  widget.movieList[widget.index]['show']['weight'].toString(),
              rating: widget.movieList[widget.index]['show']['rating']
                          ['average'] ==
                      null
                  ? "N/A"
                  : widget.movieList[widget.index]['show']['rating']['average']
                      .toString(),
            ),
          ),
          SliverToBoxAdapter(
            child: AboutMovie(
              aboutMovie:
                  widget.movieList[widget.index]['show']['summary'].toString(),
              poster: widget.movieList[widget.index]['show']['image']
                      ['original']
                  .toString(),
            ),
          )
        ],
      ),
    );
  }
}

class DetailsHeader extends StatelessWidget {
  DetailsHeader(
      {super.key,
      required this.image,
      required this.name,
      required this.year,
      required this.genres});
  String image;
  String name;
  String year;
  List genres;

  void tap() {
    print("button is clicked!");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List defaultGenre = ["Comedy", "Drama", "Action"];

    return Stack(
      //alignment: Alignment.center,
      children: [
        Container(
          height: screenHeight * 0.6,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        Container(
          height: screenHeight * 0.6,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: overlayGradient,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 60,
          left: 20,
          child: SizedBox(
            child: Container(
              width: screenWidth - 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: screenWidth * 0.80 - 50),
                    //width: screenWidth * 0.8,
                    child: AutoSizeText(
                      name,
                      style: detailTitlev2,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: screenWidth * 0.12,
                    child: Text(
                      year.split("-")[0],
                      style: yearTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            left: 10,
            right: 0,
            bottom: 15,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: screenWidth - 10,
                      child: ListView.builder(
                          padding: EdgeInsets.only(left: 15),
                          scrollDirection: Axis.horizontal,
                          itemCount: genres.isEmpty
                              ? defaultGenre.length
                              : genres.length,
                          itemBuilder: (context, i) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 3, bottom: 3),
                                  child: Text(
                                    genres.isEmpty
                                        ? defaultGenre[i]
                                        : genres[i],
                                    style: genreStyle,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(62, 109, 109, 109),
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ],
            )),
      ],
    );
  }
}

class RatingSection extends StatelessWidget {
  RatingSection(
      {super.key,
      required this.rating,
      required this.imdbCode,
      required this.weightScore});
  String weightScore;
  String rating;
  String imdbCode;

  _launchURL({required String urlEndpoint}) async {
    final Uri url = Uri.parse('https://www.imdb.com/title/${urlEndpoint}');
    if (await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth - 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              //padding: EdgeInsets.only(top: 15),
              width: screenWidth - 50,
              height: 1,
              color: deviderColor),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      weightScore,
                      style: score,
                    ),
                    SizedBox(
                      height: 1.5,
                    ),
                    Text("Metascore", style: scoreHouse),
                    SizedBox(
                      height: 1.5,
                    ),
                    Text("metascore.com", style: genreStyle)
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFFffaa00),
                    ),
                    Text("${rating}/10",
                        style:
                            score.copyWith(color: Colors.white, fontSize: 25)),
                    SizedBox(
                      height: 1.5,
                    ),
                    Text("1,234 votes", style: genreStyle)
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL(urlEndpoint: imdbCode);
                  },
                  child: Image.asset(
                    "assets/images/imdb.png",
                    height: 40,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              //padding: EdgeInsets.only(top: 15),
              width: screenWidth - 50,
              height: 1,
              color: deviderColor),
        ],
      ),
    );
  }
}

class AboutMovie extends StatefulWidget {
  AboutMovie({super.key, required this.poster, required this.aboutMovie});
  String poster;
  String aboutMovie;

  @override
  State<AboutMovie> createState() => _AboutMovieState();
}

class _AboutMovieState extends State<AboutMovie> {
  late String textWithoutHtmlTags;
  @override
  void initState() {
    removeHtmlTags(widget.aboutMovie);
    textWithoutHtmlTags;
    super.initState();
  }

  String removeHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    textWithoutHtmlTags = htmlString.replaceAll(exp, '');
    return textWithoutHtmlTags;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.3,
      padding:
          EdgeInsets.symmetric(vertical: 25, horizontal: screenWidth * 0.05),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  //height: screenHeight * 0.3,
                  width: screenWidth * 0.35,
                  child: Image.network(widget.poster))),
          SizedBox(
            width: screenWidth * 0.05,
          ),
          Center(
            child: Container(
                // height: screenHeight * 0.25,
                width: screenWidth * 0.5,
                child: SingleChildScrollView(
                  child: Text(
                    textWithoutHtmlTags,
                    style: sectionTitleTextStyle.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 16),
                    // textAlign: TextAlign.justify,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
