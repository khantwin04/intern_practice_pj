import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostModel {
  final int? userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  //factory PostModel.fromJson()
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        userId: json['userid'] as int?,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String);
  }
}
