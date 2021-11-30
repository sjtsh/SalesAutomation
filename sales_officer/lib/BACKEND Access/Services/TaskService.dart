import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sales_officer/BACKEND%20Access/Entities/SOActivity.dart';
import 'package:sales_officer/BACKEND%20Access/Entities/Task.dart';

class TaskService {
  Future<List<Task>> fetchTasks() async {
    int aStockCode = 0;
    while (aStockCode != 200) {
      try {
        final response = await http.get(Uri.parse(
            "https://asia-south1-hilifedb.cloudfunctions.net/getTasks"));
        aStockCode = response.statusCode;
        if (response.statusCode == 200) {
          List<dynamic> values = jsonDecode(response.body);
          List<Task> tasks = values.map((e) => Task.fromJson(e)).toList();
          return tasks;
        } else {
          throw Exception("failed to load post");
        }
      } on SocketException {
        throw Exception("failed to load post");
      } on TimeoutException {
        throw Exception("failed to load post");
      }
    }
    throw Exception("Something Went Wrong");
  }
}
