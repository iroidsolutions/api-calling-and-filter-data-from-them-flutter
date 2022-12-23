// Future<Model> fetchModel() async {
//   var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
//   final res = await http.get(url);
//   var resbody;
//   if (res.statusCode == 200) {
//     resbody = res.body;
//     print(resbody);
//   } else {
//     print(res.statusCode);
//   }
//   return Model.fromJson(jsonDecode(resbody));
// }

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:restroapiproject/model.dart';

class Responses {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

  Future<List<Model>> fetchData() async {
    final res = await http.get(url);
    List<dynamic> body = jsonDecode(res.body);
    print(res.body.length);

    List<Model> data = [];

    for (int i = 0; i < body.length; i++) {
      data.add(Model(
          userId: body[i]['userId'],
          id: body[i]['id'],
          title: body[i]['title'],
          completed: body[i]['completed']));
    }

    return data;
  }
}
