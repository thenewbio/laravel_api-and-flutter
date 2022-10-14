import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laravel_api/model/student_model.dart';
import 'package:http/http.dart' as http;

class StudentProvider with ChangeNotifier {
  List<Student> _students = [];
  List<Student> get students {
    return [..._students];
  }

  Future<void> fetchStudent() async {
    var url = Uri.parse('pass the url to your api here');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body);
      // print(extractedData);
      if (extractedData == null) {
        return;
      }
      final List<Student> loadStudents = [];
      extractedData.forEach((data) {
        loadStudents.add(Student(
          id: data['id'],
          name: data['name'],
          about: data['about'],
          email: data['email'],
          password: data['password'],
        ));
      });

      _students = loadStudents;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<http.Response> createStudent(
      String name, String about, String email, String password) {
    return http.post(
      Uri.parse('pass the url to your api here'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'about': about,
        'email': email,
        'password': password
      }),
    );
  }
}
