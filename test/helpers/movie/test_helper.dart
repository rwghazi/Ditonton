import 'package:ditonton/data/movie/datasources/db/movie_database_helper.dart';
import 'package:ditonton/data/movie/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/movie/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/movie/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
