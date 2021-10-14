import 'package:core/data/tv/models/tv_model.dart';
import 'package:core/domain/tv/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
     name: 'name',
    voteAverage: 1.0,
    voteCount: 1, 
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should be a subclass of TV Series entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
