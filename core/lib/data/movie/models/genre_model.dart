import 'package:core/domain/movie/entities/genre.dart';
import 'package:equatable/equatable.dart';

class MovieGenreModel extends Equatable {
  MovieGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory MovieGenreModel.fromJson(Map<String, dynamic> json) => MovieGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  MovieGenre toEntity() {
    return MovieGenre(id: this.id, name: this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
