import 'package:Netflix/data/apis/api_value.dart';
import 'package:Netflix/screens/details_screen.dart';
import 'package:Netflix/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_bar/app_bar_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  String selectedSortOption = 'None';
  String selectedFilterOption = 'None';
  List searchList = [];
  ApiValue apiValue = ApiValue();

  Future<dynamic> _searchmethod() async {
    var data = await apiValue.searchMovie(searchText);
    setState(() {
      searchList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: PreferredSize(
        preferredSize: Size(width, 100),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return Container(
              // height: 100,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Color.fromARGB(255, 0, 0, 0)
                  .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
              child: SafeArea(
                  child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 51, 51, 51)),
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  onSubmitted: (value) {
                    _searchmethod();
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search Movies',
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              )),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                searchList.isEmpty
                    ? Container(
                        height: height * 0.8,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/movie_search.png",
                                color: Color.fromARGB(255, 39, 39, 39),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Search Your favorite movie',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: height, // Adjust the multiplier as needed
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.75,
                          ),
                          scrollDirection: Axis.vertical,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailsScreen(
                                      index: index,
                                      movieList: searchList,
                                    );
                                  }),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      searchList[index]['show']['image']
                                                      ['medium'] ==
                                                  null ||
                                              searchList[index]['show']
                                                      ['image'] ==
                                                  null ||
                                              searchList[index]['show']
                                                      ['image'] ==
                                                  "null" ||
                                              searchList[index]['show']['image']
                                                      ['original'] ==
                                                  null
                                          ? 'https://cdn.pixabay.com/animation/2022/07/29/03/42/03-42-22-68_512.gif'
                                          : searchList[index]['show']['image']
                                              ['medium'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
