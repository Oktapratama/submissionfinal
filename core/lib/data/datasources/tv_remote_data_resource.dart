import 'dart:convert';
import 'package:core/data/models/tv/tv_detail_model.dart';
import 'package:core/data/models/tv/tv_model.dart';
import 'package:core/data/models/tv/tv_response.dart';
import 'package:http/http.dart' as http;

import '../../utils/exception.dart';

abstract class TvRemoteDataSource {
  Future<List<ModelTv>> getNowPlayingTv();
  Future<List<ModelTv>> getPopularTv();
  Future<List<ModelTv>> getTopRatedTv();
  Future<ModelDetailTv> getTvDetail(int id);
  Future<List<ModelTv>> getTvRecommendations(int id);
  Future<List<ModelTv>> searchTv(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ModelTv>> getNowPlayingTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return ResponseTv
          .fromJson(json.decode(response.body))
          .tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ModelDetailTv> getTvDetail(int id) async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return ModelDetailTv.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ModelTv>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return ResponseTv
          .fromJson(json.decode(response.body))
          .tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ModelTv>> getPopularTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return ResponseTv
          .fromJson(json.decode(response.body))
          .tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ModelTv>> getTopRatedTv() async {
    final response =
    await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return ResponseTv
          .fromJson(json.decode(response.body))
          .tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ModelTv>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return ResponseTv
          .fromJson(json.decode(response.body))
          .tvList;
    } else {
      throw ServerException();
    }
  }
}