import 'package:core/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class ResponseTv extends Equatable {
  final List<ModelTv> tvList;

  ResponseTv({required this.tvList});

  factory ResponseTv.fromJson(Map<String, dynamic> json) => ResponseTv(
    tvList: List<ModelTv>.from((json["results"] as List)
        .map((x) => ModelTv.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvList];
}