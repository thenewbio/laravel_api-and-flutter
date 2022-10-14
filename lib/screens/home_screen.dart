import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:laravel_api/main.dart';
import 'package:laravel_api/provider/provider.dart';
import 'package:laravel_api/model/student_model.dart';
import 'package:http/http.dart' as http;
import 'package:laravel_api/screens/add_students_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _fetchAllStudent(BuildContext context) async {
    await Provider.of<StudentProvider>(context, listen: false).fetchStudent();
  }

  // ···
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchAllStudent(context),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<StudentProvider>(builder: (context, studentdata, _) {
                  return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView.builder(
                          itemCount: studentdata.students.length,
                          itemBuilder: (ctx, i) => Card(
                                color: Colors.teal,
                                child: ListTile(
                                  leading:
                                      Text('${studentdata.students[i].id}'),
                                  title: Text(studentdata.students[i].name),
                                  subtitle: Text(studentdata.students[i].about),
                                ),
                              )));
                });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_circle),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddStudent(title: 'Add Student')));
          }),
    );
  }
}
