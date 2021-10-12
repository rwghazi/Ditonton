import 'dart:convert';

import 'package:ditonton/data/tv/models/tv_model.dart';
import 'package:ditonton/data/tv/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
      backdropPath: '/path.jpg',
      genreIds: [1,2],
      id: 1,
      originalName: 'Original Name',
      overview: 'Overview',
      popularity: 1,
      posterPath: '/path.jpg',
      firstAirDate: '2020-05-05',
      name: 'Name',
      voteAverage: 1.0,
      voteCount: 1, 
    );

  final tTvResponseModel =
      TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/on_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2],
            "id": 1,
            "original_name": "Original Name",
            "overview": "Overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "release_date": "2020-05-05",
            "name": "Name",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
