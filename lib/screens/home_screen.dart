// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:Netflix/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data.dart';
import '../widgets/best_movies.dart';
import '../widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        // setState(() {
        //   _scrollOffset = _scrollController.offset;
        // });
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      floatingActionButton: FloatingButtonWidget(),
      appBar: PreferredSize(
          preferredSize: Size(screenWidth, 55),
          child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) {
              return MyAppBar(
                scrollOffset: scrollOffset,
              );
            },
          )),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: wednesdayContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverToBoxAdapter(
                child: Previews(
              key: PageStorageKey('previews'),
              title: "Previews",
            )),
          ),
          SliverToBoxAdapter(
            child: BestMovies(
              key: PageStorageKey('bestMovie'),
              title: 'Best Movies',
            ),
          ),
          SliverToBoxAdapter(
            child: ContnetList(
              title: "My List",
              contentList: myList,
              key: PageStorageKey('MyList'),
            ),
          ),
          SliverToBoxAdapter(
            child: ContnetList(
                title: "Netflix Orignals",
                key: PageStorageKey('netflixOrignals'),
                isOrignals: true,
                contentList: originals),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 25),
            sliver: SliverToBoxAdapter(
              child: ContnetList(
                  title: "Trending",
                  contentList: trending,
                  key: PageStorageKey('trendings')),
            ),
          )
        ],
      ),
    );
  }
}
