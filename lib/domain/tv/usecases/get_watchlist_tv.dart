import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/tv/entities/tv.dart';
import 'package:ditonton/domain/tv/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTv {
  final TvRepository _repository;

  GetWatchlistTv(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTv();
  }
}
