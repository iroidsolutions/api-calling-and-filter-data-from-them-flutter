import 'package:json_annotation/json_annotation.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'model.g.dart';

@RestApi(baseUrl: "https://jsonplaceholder.typicode.com")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/todos")
  Future<List<Model>> getModels();
}

@JsonSerializable()
class Model {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Model(
      {required this.userId,
      required this.id,
      required this.title,
      required this.completed});

  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);

  // Map<String, dynamic> toJson() => _$ModeltoJson(this);
}
