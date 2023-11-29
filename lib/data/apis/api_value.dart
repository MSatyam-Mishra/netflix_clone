import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'Dio/dio_client.dart';

class ApiValue {
  static String url = "https://api.tvmaze.com/";
  static String showsURL = "search/shows";
  static String allShowsURL = 'schedule';

  //==========================================APIs for Movies===========================================

  final DioClinet _dioClinet = DioClinet.instance;

  Future<dynamic> fetchShows() async {
    dynamic data = {
      'date': DateTime.now().toString().substring(0, 10),
    };

    try {
      Response response =
          await _dioClinet.dio!.get(allShowsURL, queryParameters: data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<dynamic> allMovieList() async {
    dynamic data = {
      'q': 'all',
    };

    try {
      Response response =
          await _dioClinet.dio!.get(showsURL, queryParameters: data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<dynamic> searchMovie(String search) async {
    dynamic data = {
      'q': search,
    };

    try {
      Response response =
          await _dioClinet.dio!.get(showsURL, queryParameters: data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
}
