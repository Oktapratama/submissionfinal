import 'package:equatable/equatable.dart';
import '../../../domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';

class TableTv extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TableTv({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TableTv.fromEntity(DetailTv tv) => TableTv(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory TableTv.fromMap(Map<String, dynamic> map) => TableTv(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  Tv toEntity() => Tv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}