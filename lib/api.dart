import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kkm/models/comment_model.dart';
import 'package:kkm/models/post_model.dart';

class Api {
  String url = 'https://jsonplaceholder.typicode.com';

  Future<List<PostModel>> fetchPost() async {
    final response = await http.get(Uri.parse("$url/posts"));
    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body) as List<dynamic>;
      return responseList.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('fail to load');
    }
  }

  Future<List<commentModel>> fetchComments(int id) async {
    final response = await http.get(Uri.parse("$url/posts/$id/comments"));
    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body) as List<dynamic>;
      return responseList.map((e) => commentModel.fromJson(e)).toList();
    } else {
      throw Exception('fail to load');
    }
  }
}
